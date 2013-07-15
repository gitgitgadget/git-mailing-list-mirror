From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 3/6] diff: allow --patch & cie to override
 -s/--no-patch
Date: Mon, 15 Jul 2013 11:09:09 -0700
Message-ID: <20130715180908.GE14690@google.com>
References: <20130715173536.GB14690@google.com>
 <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
 <1373910925-18422-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 20:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UynD3-00030z-Ls
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 20:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab3GOSJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 14:09:13 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:60611 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab3GOSJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 14:09:12 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so11511539pac.12
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MtmOOva6zGbSThv0sYiuf+5ESepx5UrFywAjQcKuK4A=;
        b=0d9vM+QencdrjmRvgDR/GXnuldeYZmzuFT4I8+EqkPkp5vt2+erPeEJ8nezXSc86fo
         slYoRSm6OChPDXeYEBLcDXuzkGg3FYWY/43AD/XRK5pKrn9PslRDDAGBmr5aBSNVXogK
         C/G1R4zWcpugndWd8NBmTiq9au6CoYiaA9s5XrLd2AQQf4FpjfWmqhiFst914TK63t4F
         G+61wfKlVviTV/rqO1UPvIeoJn9jvjXURewTunTlKyej8MaS4KiT4FHMrUSquPCdIi6k
         fAGLJiqmbl6QbS10Vos3CkEO/NF4OGWeFihgSmmVukr0mt8PnteaYd4f+KCT+Gwj5owB
         s05A==
X-Received: by 10.68.59.98 with SMTP id y2mr54224361pbq.135.1373911752469;
        Mon, 15 Jul 2013 11:09:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id uj1sm5569298pac.21.2013.07.15.11.09.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 11:09:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373910925-18422-4-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230511>

Matthieu Moy wrote:

> All options that trigger a patch output now override --no-patch.
>
> The case of --binary is particular as the name may suggest that it turns

Usage nit: this should say "is unusual" or "In the case of --binary in
particular, the name may suggest ...".

> a normal patch into a binary patch, but it actually already enables patch
> output when normally disabled (e.g. "git log --binary" displays a patch),
> hence it makes sense that "git show --no-patch --binary" display the
> binary patch.
[...]
> --- a/t/t4000-diff-format.sh
> +++ b/t/t4000-diff-format.sh
> @@ -71,4 +71,9 @@ test_expect_success 'git diff-files --no-patch as synonym for -s' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success 'git diff-files --no-patch --patch shows the patch' '
> +	git diff-files --no-patch --patch >diff-np-output 2>err &&
> +	compare_diff_patch expected actual

Shouldn't that be "compare_diff_patch expected diff-np-output"?

A couple of other test ideas:

 - "git diff-files --patch --no-patch"
 - "git diff-files -s --patch-with-stat"

Aside from that, the patch looks good.

Thanks,
Jonathan
