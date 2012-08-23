From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Existing utility to track compiled files in another sister
 repository, for rollouts
Date: Thu, 23 Aug 2012 10:57:34 -0700
Message-ID: <7vk3wp4hkh.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6SVSn17nfSarQC1qgz-TxcDDn5tvHb0BkyW9S8DcLY4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 19:57:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4bf6-0001Ix-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 19:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232Ab2HWR5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Aug 2012 13:57:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933689Ab2HWR5h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 13:57:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0908691AF;
	Thu, 23 Aug 2012 13:57:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vmi+cF0wLyAK
	hQob3hqp17GpqMI=; b=ISnHaPVPSLDioiBQvAzjwWCvepM7Zw1qhsCzeIw7f0+c
	ykUeU22nv5mWh5alg074g5CyCx+icjVHNYUEW8+/XBytMGTGo06O+drKTHY/vP5X
	x/B4O+IwDvVDY4jtbNoP0DTclkMmvk7YC8STjL+1uqCdJVoVyZy/lLWhPN4FBr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Qzo9+p
	u9y9ZUqtKKibAhoxe7izX6Vj0sJPDG5H2xiaS7YaED4borg7M6uGlmM0GQE48RGx
	LbR8WUOaaz+4FIpBiEv/pC6R57HoSEInbYZgXay7FOJ3b7Dp6ALPaBDlMzelMUnU
	HFvaSj2yIgg7z7Eew/uyK0Hx2zfF4MaHacSsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAEA591AE;
	Thu, 23 Aug 2012 13:57:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4491991AD; Thu, 23 Aug 2012
 13:57:36 -0400 (EDT)
In-Reply-To: <CACBZZX6SVSn17nfSarQC1qgz-TxcDDn5tvHb0BkyW9S8DcLY4w@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Aug
 2012 18:28:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05781B36-ED4C-11E1-B2E5-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204161>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>  5. Copy those to to software-generated.git, removing any that we
> didn't just create, adding any that are new
>  6. Commit that, tag it with generated-deployment-YYYYMMDD-HHMMSS

>  9. Do git clean -dxf on software.git remove old generated files
>  10. Copy new generated files from generated-software.git to software=
=2Egit
>
> For this I'll need to write some "git snapshot-commit" tool for #5 an=
d
> #6 to commit whatever the current state of the directory is (with
> removed/added files), and hack up something to do #9-#10.
>
> This should all be relatively easy, I was just wondering if there was
> any prior art on this that I could use instead of hacking it up
> myself.

=46WIW, dodoc script in my todo branch was hacked up to respond to my
push into k.org repository, pull 'master' into "documentation build
repo" at the k.org machine and check it out, build docs and then
"removing any that we didn't create, adding any that are new" to
update the html and man "branches", and push it back to the main
repository, so in that sense, it has all the logic that was needed
(and more, as the rebuilt documentation from two revisions may only
differ from version stamp asciidoc-to-html/man toolchain adds, which
need to be filtered out when updating html/man branches).

There no longer is post-update hook at k.org, so I have to run it
manually at the end of day's integration cycle, just before pushing
things out.

I wrote it myself, not because I looked for suitable reusable code
and didn't find any, but because I was too lazy to look for existing
tools and evaluating them.
