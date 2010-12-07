From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] describe: Use for_each_rawref
Date: Tue, 07 Dec 2010 13:59:58 -0800
Message-ID: <7vr5dtnt0h.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
 <20101203084348.GD18202@burratino>
 <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
 <20101206073214.GA3745@burratino>
 <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <20101207095818.GB1867@neumann>
 <alpine.DEB.2.02.1012071320240.23348@dr-wily.mit.edu>
 <alpine.DEB.2.02.1012071325100.23348@dr-wily.mit.edu>
 <7vsjy9pdmg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 23:00:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ5aH-0000mz-Q5
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 23:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab0LGWAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 17:00:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab0LGWAY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 17:00:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8283D2970;
	Tue,  7 Dec 2010 17:00:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4ORy7qDmc9mj
	p6hOc110yYmNGIQ=; b=n1vbxJHzWk6qun7uLEpenARKj2ZQv1dUW9tuF02TQCME
	SCNRlBQNE0nZ/Nrsf+Ff/jVSC21FuK9/LBXLOtOg6MJXk4/Skmy2Ki0+riEYWoJT
	3SwZQs35brNrTRr+FkoczlUr2YtOVdf04jUVi6pqa8s3nQpU5Wm/TgdGCBsioVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fbU0yK
	JVgHiekUwgBm3lRaPiOay35xZmnqwlCljt3KGwkaMgkMTbpG4Fds4tx3sTR+rKo9
	PAx4yyc54kSurjuxVYlJ7AlBRy8FMZrBzlqARaLDMFNR4CB5f09U+RmHofMXPO9z
	Awsw2K/r1xp97+ue8cKoJ212iOPSZ1niCTyC0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E895F295A;
	Tue,  7 Dec 2010 17:00:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 105AF293D; Tue,  7 Dec 2010
 17:00:22 -0500 (EST)
In-Reply-To: <7vsjy9pdmg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 07 Dec 2010 11\:49\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AD373F4-024D-11E0-91AC-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163142>

Junio C Hamano <gitster@pobox.com> writes:

> Anders Kaseorg <andersk@ksplice.com> writes:
>
>> On Tue, 7 Dec 2010, Anders Kaseorg wrote:
>>> Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
>>>=20
>>> diff --git a/builtin/describe.c b/builtin/describe.c
>>
>> (Gaaah, sorry, I accidentally used format-patch -p here.  Won=E2=80=99=
t happen=20
>> again.  :-) )
>
> The default will work just fine, no?
>
> Also labelling them like "[PATCH v2 1/2]" would have been nicer to sp=
ot
> the progress of the series.

Two more requests.

 * Please describe what was changed since earlier interations after "--=
-"
   lines;

 * Please run tests before submitting patches.  It appears to break t74=
07.

What breaks in t7407 is "git submodule status --recursive" output.  In =
my
environment, it used to describe the tip as heads/master but after the
patch it says remotes/origin/master.  The output from "describe --all"
does not tiebreak between one branch from another, even though it does
favor tags over branches (and tries to use annotated ones), so it is no=
t a
real regression in that sense, but then the test needs to be fixed not =
to
care about which equally good branches are shown.

Some might even argue that it is more relevant to show how the commit
relates to remote-tracking branch heads.  That is a separate issue (if
this position is widely supported, we would introduce another "prio"
between "all others (0)" and "lightweight tags (1)" for remote-tracking
branches), though.
