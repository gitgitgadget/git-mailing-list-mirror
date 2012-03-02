From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Fri, 02 Mar 2012 10:53:00 -0800
Message-ID: <7vzkbydecz.fsf@alter.siamese.dyndns.org>
References: <7v4nu7ilee.fsf@alter.siamese.dyndns.org>
 <1330695744-13854-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:53:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3XbI-000733-Vn
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 19:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab2CBSxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 13:53:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115Ab2CBSxC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 13:53:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E94AC67D4;
	Fri,  2 Mar 2012 13:53:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AfeL8WKi39HR
	9uYqKUyuRw5y2i8=; b=n3r6OKLCVVR2VughqzhhC50gBsQ9S+hzmzTZr6tWV1k2
	N0GoXdv9m1MuSmyXzna/7gsKy1vgjAhoHG/xalj5w9wcAN7Z8lVw2PXLhD94dGpg
	F0Qdin3ZfbCnMf92ukIkdsLedzDebhbD6aloSEBjGgBqoWWOzC4HbGlzNvhEnnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ktu6AP
	B2LXPEb/SQjecE4/D4S0zxnJ0XQNsyUDyltGa8X+PM8+ulO10DqPHMYRhMLh9fEY
	QUjsH4DXBpTAG55Ui17ZvdQ+/WRdrYqU/drHq2ralbntDphGQNoVdoI4s+FXvoCs
	nYWJ8hcxsaQhwFJ0fKQN/yaZsR3abx0ZxelTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E12FF67D3;
	Fri,  2 Mar 2012 13:53:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76D6667D1; Fri,  2 Mar 2012
 13:53:01 -0500 (EST)
In-Reply-To: <1330695744-13854-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 2 Mar
 2012 20:42:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF924D5A-6498-11E1-BF63-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192061>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  One other thing. I did not consider to run fix_unresolved_deltas() i=
n
>  parallel originally because I didn't think it could be done. It can.
>  But I'm not sure it's worth the effort. Anyway we can do that later
>  if it turns out worth it.

My hunch agrees with your "not sure it's worth", as these are objects a=
t
the boundary of --thin transfer, which should only be proportional to t=
he
size of a single snapshot, not the depth of history, and I think your "=
we
can do that later" is a sound judgement.

Thanks.
