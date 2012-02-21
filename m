From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Tue, 21 Feb 2012 12:10:31 -0800
Message-ID: <7v1upogd6w.fsf@alter.siamese.dyndns.org>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
 <7v4nuljcnk.fsf@alter.siamese.dyndns.org> <4F42E4C2.7070801@in.waw.pl>
 <7vr4xois3l.fsf@alter.siamese.dyndns.org> <4F436C5D.7070606@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Feb 21 21:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzw2q-0004Tk-5q
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 21:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab2BUUKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 15:10:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab2BUUKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 15:10:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3108E7637;
	Tue, 21 Feb 2012 15:10:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=/8MQCpO8FsAGy+Asoi577mXfU
	Ck=; b=TqR20c1X9eCnH4mQArq1G66k1Mgxg65yy1w2ekJcWJxNNVdyJWZMv0lXM
	8nkbOgkRdIpU0YmyVn28u2c4ZsxxfO3Lj6spm4Dbww98y3Rp1VZxknGyXOgXhASb
	J4xpYCyyDPcPwSCKDU6272LKnqq8Rp61IEYQdl4jnmFaNww074=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=R0zdl05XYJ1/bP5rnb+
	j5T8rvpySziYoOWWYWHCgJtjgK/QpIr7NiqFmORH5twyvEwEitOiuStwTHbHRTkN
	By4KnahrC+pKgwAiQJuxWeWy27no5YnwxNpf8b75g4FxH+8YAgxnJKEwtDmvsY5b
	ZRo3jiYZoUjBhAL17h1+yhdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27D0C7636;
	Tue, 21 Feb 2012 15:10:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B256B7635; Tue, 21 Feb 2012
 15:10:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BCC76D0-5CC8-11E1-9076-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191179>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> This seem overly complex. A nice property to have would be
> "if the window is wide enough so there's enough space for full
> filenames, the graph part scales monotonically with the change count"=
=2E
> (If there's filename truncation, than there just isn't enough space
> for everything and the graph may be compressed. But otherwise, if we
> have two graphs which do not end at the edge of the screen, and the
> second one is wider than the first one, then without looking at the
> change counts we know that the second one has more changes).
>
> For this property to be satisfied, the graph_width limit would have t=
o
> be independent of the filename width.
>
> So maybe it should be ...

Sorry, the desired property I would understand, but that does not click
with your "have to be independent" conclusion, so I do not have comment=
 on
the "maybe it should be..." part.

The resolution requirement may want to set a "desired lower limit" for =
the
width of the graph, but it is only "desired" because it is possible tha=
t
you have to bust the limit if you have three files with 1, 9999 and 100=
00
changed lines and your terminal is only 200 columns wide.

The current code caps name part to 50/80, but allows the graph to use m=
ore
when you have only shorter names.  Perhaps you can follow the same logi=
c
in the first part of your [7/8] (which needs to be separated to at leas=
t
in two pieces, as it conflates the "lift 50-column cap from the name wi=
dth
and make it proportional to the term_width()" part and "but cap the gra=
ph
part to 40-column" part, that are separate topics)?  Then we can try
different heuristics to find a better way to cap the length of the grap=
h
on top?
