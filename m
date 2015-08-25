From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client
 specs.
Date: Tue, 25 Aug 2015 07:54:18 +0100
Message-ID: <55DC111A.6090501@diamand.org>
References: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pw@padd.com, torarvid@gmail.com, ksaitoh560@gmail.com,
	tboegi@web.de, sunshine@sunshineco.com, gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 08:56:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU8AC-0007J3-GX
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 08:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbbHYG41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 02:56:27 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35907 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbHYGyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 02:54:23 -0400
Received: by wicja10 with SMTP id ja10so5166630wic.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SRoeZsoHMVi4A/MvlRzXLZPLb2f1yN7+L+IqfsGSBmw=;
        b=PnKT1TrQnRRo2MoUj9CLhWlCEoX0TDyceuwG3LTwXs3IsolojBZ9659cMg+V45wXTf
         JslzmhTyBDf6LNFji32xrX8DSzwtwsDaZkbpujcCATeZ62RvvqTa9x4OXRwDN4LIfhyx
         ENxGEymTMgU1wKwDx9o3BIhqckDccXdCK9dDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=SRoeZsoHMVi4A/MvlRzXLZPLb2f1yN7+L+IqfsGSBmw=;
        b=SPX3TNoua/b1AFRj2bnJLglrdHsBmGOdF6SaF+0BZ2Mh/QI5QH+xo4QweU03l2yu+/
         mGksYVY3+KC6aa68m3VuTh1FArUmadoiMp957G6lW15ECG4tVG4kA3Q6R1LV93sfDrHu
         s2NLUdzEMQb4FXOurS1Gpoves+/n5PpRvgxXLNxCy6Ga/mM/3ataGndsol2dmvyX/Y5v
         /pPYDxMAk4Hf2NA9mjSJ1XP3sSxotVk77FA/HlxSd45BM2BDxye97PkugRCBH06UJ4GE
         dk8Sj6zGtAO1sFXeHLh8WPl6jCLCJSaRB2EsjsF9SW1FdbAFXNPA+srWsn6sE2p+D39p
         FlTQ==
X-Gm-Message-State: ALoCoQk2H+LPrlZAAqzX799qyC1tnP4A6110OSmGHSdTT699kAyNTTjpuf+WOUKliCA2kbF42tNO
X-Received: by 10.180.106.68 with SMTP id gs4mr1998386wib.61.1440485662051;
        Mon, 24 Aug 2015 23:54:22 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by smtp.gmail.com with ESMTPSA id jr5sm26553555wjc.14.2015.08.24.23.54.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2015 23:54:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276508>

On 24/08/15 22:30, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Thanks to Luke Diamand I realized the core problem and propose here a
> substiantially simpler fix to my PATCH v4.
>
> The test cases remain and prove the problem. In particular
> "8 - Clone path (ignorecase)" and
> "Add a new file and clone path with new file (ignorecase)" fail with the
> current implementation on OS X and Linux.

That's a lot simpler, thanks!

Could we give this its own command line option and git config variable?

Core.ignorecase gets set if the client is on a filing system that 
ignores case. This is slightly different - it squashes case in depot 
files for people with depots that have incorrectly jumbled-up case.

Conflating the two seems like it would cause confusion at some point - 
for example, I have no idea how the rest of git behaves if 
core.ignorecase is set to True on a case-preserving file system.

It would probably be necessary to change p4PathStartsWith() to also 
check the same flag.


>
> Lars Schneider (1):
>    git-p4: Obey core.ignorecase when using P4 client specs.
>
>   git-p4.py                         |   7 ++
>   t/t9821-git-p4-path-variations.sh | 200 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 207 insertions(+)
>   create mode 100755 t/t9821-git-p4-path-variations.sh
>
> --
> 1.9.5 (Apple Git-50.3)
>
