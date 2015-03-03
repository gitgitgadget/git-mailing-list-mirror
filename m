From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] t7508: test git status -v
Date: Tue, 03 Mar 2015 13:20:17 -0800
Message-ID: <xmqqr3t5aicu.fsf@gitster.dls.corp.google.com>
References: <54B8C82E.8000707@drmicha.warpmail.net>
	<4979bf9de04197c1cd0d4a6af1348b45d4b0894c.1425390756.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSuEu-0006KX-KT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 22:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbbCCVUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 16:20:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756580AbbCCVUV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 16:20:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D4293DB77;
	Tue,  3 Mar 2015 16:20:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oM1CjkdC9S7zUd0gh9cKQB779j4=; b=wLZjc1
	7AITQP/Il/D/z9RqY/a9vcDYGZBEpe3ySAxOhR/q8K8EhwHfPLWh+5N0il9y+Z5e
	aaTsJkYXIm3Z9cliyf/O9/V300CvAaVI9cY8i+kEWFvKJNT3Ps3vSfN0NkTJSIs6
	oWRV32KJWWZTMrSfJO54IXTXB00O5q0jRQZhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SirQagPohdFiuVxbU1L/PcB5CFA7/4En
	4m5XrhcHCHHREOYwqri8hvuk/Afjm+9a6BG0fVlS9fefLrpHiOutrshT4VoWpRrb
	B/bRd2gFrYs+oPpI6zIGJqbadJY8HlEVhdZEtRjpAWACPVSav4qtyNrOQfAPjtfi
	5j5u8SePR+I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 350353DB76;
	Tue,  3 Mar 2015 16:20:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97B6C3DB75;
	Tue,  3 Mar 2015 16:20:18 -0500 (EST)
In-Reply-To: <4979bf9de04197c1cd0d4a6af1348b45d4b0894c.1425390756.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 3 Mar 2015 15:16:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 17AA065E-C1EB-11E4-A506-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264691>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t7508-status.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 8ed5788..4989e98 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -133,6 +133,12 @@ test_expect_success 'status with status.displayCommentPrefix=false' '
>  	test_i18ncmp expect output
>  '
>  
> +test_expect_success 'status -v' '
> +	git diff --cached >>expect &&

This makes the test rely on the previous one succeeding.  Do we
care, or is reproducing what ought to be in 'expect' at this step
too expensive?

> +	git status -v >output &&
> +	test_cmp expect output
> +'
> +
>  test_expect_success 'setup fake editor' '
>  	cat >.git/editor <<-\EOF &&
>  	#! /bin/sh
