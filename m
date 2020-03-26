Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91232C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 22:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBD32077D
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 22:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh88sKYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZWhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:37:53 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:50191 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZWhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 18:37:53 -0400
Received: by mail-wm1-f41.google.com with SMTP id d198so9290976wmd.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0ZN3ecmTheEshI4gLLr5Lx0MiZcRFnDFK+NsSbEzuSI=;
        b=Kh88sKYjuTlBt8fmxyC89YihZePkMpxpw0bGwoWRzU4NiffL0JjmIfW2OIE82oH0b5
         QG7yygAMuGMEOWFwVyC2l1Ol4OMzddyPxjiVTpG1H2PkBhijAEVbX/V1M/Wd5TbBjK3v
         rCr2LZFebauV4O+MTC8qLibXitmPqosX4zTicVb/gF+EaIF406iwsjtOsQGQr6t+bRC2
         Jh1pNM1HFeX2xp6iBv2D/u9+n/Bi8/FQWnPAAByzDztF6V0PT4t+2flqejLEfhwB0qou
         1B0NhkuiL9OK5EK7Rg5UkaOg9bHiaO7FORUpBjAEqpoD616R4WF/Dp7CiBNB+eix1CYl
         LQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0ZN3ecmTheEshI4gLLr5Lx0MiZcRFnDFK+NsSbEzuSI=;
        b=DpIbaIDididOoV/Si/6dWcrpJFXgAlMzOgqwhKf2gBRRg2+/2havmXaLrncBJAe8W5
         UKGqnT+2rScOAlEnhWk9Ic8CPSU683z1Du2TPGSMpwDn8LBEMXHwpFs+wirFNQURZLvD
         nlrJzM++x4k42CT7Y7FEsiKPyAQixVxYSqsnwEZlhsFJqn8aNfaxHKiKCWqQ30o1kcJp
         XBgZcADcH0YBtjtQIanWJzs5xMB1BX67cJj/0qitoI7b7IKLFQjTmHGVqlB+M2Btw9qB
         gL+9TamYq7cbQxYwGZ1ooTxYfAA7y8HUWGY4p1ZCrY+6LundJN+COC0J2zRPtIZ+L69G
         t2JQ==
X-Gm-Message-State: ANhLgQ3sHD//Ftzx8AS7rB+KE0ahZiwhUdlYh2feMwgDOJ46KfSfpIRC
        TulxzXKORqI2Tr7gie/lLDG/PcLQRbUC4A==
X-Google-Smtp-Source: ADFU+vshUUkzlNpDsQVnez+o7GRzfbrb5pY6sdCqTpELI8c2OT3SMJgLz+8qZPMrhf9kWu6BcicLMA==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr11477864wrr.321.1585262271181;
        Thu, 26 Mar 2020 15:37:51 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id h5sm5404797wro.83.2020.03.26.15.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:37:50 -0700 (PDT)
Date:   Thu, 26 Mar 2020 23:37:49 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Phillip Susi <phill@thesusis.net>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 3/17] Obliterate
Message-ID: <20200326223749.ej4a3z7n37s5lw6r@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 26 Mar 2020 23:31:18 +0100
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
 <20200315221940.bdgi5mluxuetq2lz@doriath>
 <87lfo0881d.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfo0881d.fsf@vps.thesusis.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Phillip Susi, Mon 16 Mar 2020 at 14:32:46 (-0400) :
> Instead of replacing the blob with an empty file, why not replace the
> tree that references it with one that does not?  That way you won't have
> the file in your checkout at all, and the index won't list it so status
> won't show it as changed.

That's an interesting solution, but it only works if the tree itself does
not change.

- This is the case when these large objects were uploaded and then removed
  in another commit [*].
  But in this case I won't checkout (usually) back to this tree anyway, so the
  error due to the missing blob is not a big problem.

- When my coauthors use git as a dropbox alternative where they upload big
  pdf files (rather than only source code or .tex files), they also want to
  keep them there. If they had uploaded these files to the special literature/
  folder I had made for them, I could just replace the literature/ tree by
  an empty one, but they managed to upload them in the root folder which is
  subject to change unfortunately, and it would be annoying to make a new
  replace ref each time.

[*] by myself usually, for instance when people commit spurious tex
generated files like eg *.synctex, despite my .gitignore (I don't know how
they manage this...)

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
