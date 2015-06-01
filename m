From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 01 Jun 2015 10:16:21 -0700
Message-ID: <xmqqiob773iy.fsf@gitster.dls.corp.google.com>
References: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTK9-0005jz-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbbFARQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:16:26 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:32873 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbbFARQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:16:24 -0400
Received: by iebgx4 with SMTP id gx4so113936827ieb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cFTvVccKV9iPFrZ5uxXEDo+4SHeBDGn+Bki29M+eRxY=;
        b=jf8HyySwtuwfmROvQaCtp3paip6e4Des1VcR7t4fZm/Wd1z/F9yKS0m97doOUCShfI
         LifWf1FtZkuGfVGRoi+ioSDC12MFhFjDm533L+oarvaVj6refUfoskA88MgUUtAsySja
         Qmjz6yeF0/SRUP6LHNYSWsNkgnNtw3fAW9hzg8KYOQO9FfwVP1Q8S0nWk/WLdaq6HVyM
         +eg/sKygWkOlGFnyKkh+z20Z638Tkau8mZG47KLSgw4vwsjbNkbXbykauD5Qc0GjwdNI
         c5+Lg5qUVK0Rq53GFZ69G0rAboWW383mlHr0mW+DVlqAlp3IHLPJ3ECVtwyzpyguAxmh
         Mb0A==
X-Received: by 10.43.89.133 with SMTP id be5mr14220211icc.2.1433178984120;
        Mon, 01 Jun 2015 10:16:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id r4sm8212125igh.9.2015.06.01.10.16.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 10:16:23 -0700 (PDT)
In-Reply-To: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr> (Remi LESPINET's message
	of "Mon, 01 Jun 2015 19:07:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270440>

Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> first original file:
>
> 10
> 20
> 30
> 40
>
> for the following diff file:
>
> @@ -1,2 +1,2 @@
>  20
> -30
> +35
>  40
>
> The patch will not be applied with a git apply command, but it will
> with a basic patch command.

Doesn't that merely indicate a bug in "patch", though?

The patch text says that the preimage must begin with "20" but the
target begins with "10".

I think we have the same "the boundary must match" logic not just
at the beginning of the file but also at the end of the file.  No
matter what the answer to the above question is, we would need to
do the same for both the beginning and the end, I would think.

Thanks.
