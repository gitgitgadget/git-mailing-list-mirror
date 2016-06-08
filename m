From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 8 Jun 2016 18:46:14 +0700
Message-ID: <CACsJy8DC_8LkZUCe=NY6wbg0+jTtwQTPE1zM1da9Vq8-PfyrsA@mail.gmail.com>
References: <20160531220818.GB46739@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 13:46:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAbwi-0000vd-0a
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 13:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbcFHLqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 07:46:46 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33605 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcFHLqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 07:46:45 -0400
Received: by mail-io0-f169.google.com with SMTP id m62so6661045iof.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 04:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=26T0FZV9bUP4+i/PrkWiIV91Phi0tLgzn3jmbVOcSq8=;
        b=AV3bADtCc7/H4TNhXfiejPZStINZk6QHrkCrjJwVqhyohOJ4Kx+czAz86xtICXF6UJ
         wpJzFt9krkQJZdQzlT6thm7SewqrLQpSEudLmrAEYuObrvKieN5hwgd1zaonEnDLqGW+
         IiCB3aoVKHoT35R8DNKxQETkeEMiO5QmWPIjt5QjrZDSGBHHy9VfwfVS8tzwrbjJiBjp
         crWXGJEeg2Tke5U/rCP5Kyo5ftjwcBCUQn2bJMEXVYW5GHGJquD+dRIwL/YSvtT/RuV+
         gxsjHG6J8lU0owEuLyq0D3BJAdXV7L5ZYQ+rggGRCgFk6toDCYj5dqH0RMdeQMM6Qlop
         zA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=26T0FZV9bUP4+i/PrkWiIV91Phi0tLgzn3jmbVOcSq8=;
        b=Cg6A/zkk518BKNB3Yz/LXun7sYohrSFovAxSCvGz1REAyeSsUGEwRqnfutrdTw2yOd
         v6fXGIzTcrp1cCSPF2aqfw+p4Qh3mBsZ6yzIroDfeIGOyc+qdpeC6XQQaXxwq0R642Oe
         scj4qlIoYjjnV9DLj7bvhO55bYaCemNen178M8Upu/E8j8aDTXcU9JIyivzVK30Z/bXU
         u4HBCLLNuvq+I9Tb4OyLxOVAmMxJcc/rMUX9937jI4KednQJn812cQpLxiNPMywzPf3o
         0REPqI9gTwU88vnhVSNRFSp2j97RipOQpivmQDS+Mjp4FJszPCpytEv5ruZ6vK02BW/3
         l/WA==
X-Gm-Message-State: ALyK8tJ3FF13naEzsaJRTNrkMSmokoMByvHU2sKztUU3aVQl8x0cxK99WmC3P+xz+vb94M1fZLAA4db3TQQCBg==
X-Received: by 10.107.8.220 with SMTP id h89mr7266078ioi.95.1465386404774;
 Wed, 08 Jun 2016 04:46:44 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 8 Jun 2016 04:46:14 -0700 (PDT)
In-Reply-To: <20160531220818.GB46739@zoidberg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296783>

On Wed, Jun 1, 2016 at 5:08 AM, Edward Thomson
<ethomson@edwardthomson.com> wrote:
> @@ -263,6 +265,7 @@ static struct option builtin_add_options[] = {
>         OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>         OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>         OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
> +       OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),

If this is only about +/-x, would --[no-]executable be a better option name?
-- 
Duy
