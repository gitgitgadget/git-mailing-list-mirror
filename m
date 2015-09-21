From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v6 0/7] git-p4: add support for large file systems
Date: Mon, 21 Sep 2015 20:45:46 +0100
Message-ID: <56005E6A.4000308@diamand.org>
References: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 21:45:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze728-0005aj-In
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 21:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbbIUTps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 15:45:48 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36081 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbbIUTpr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 15:45:47 -0400
Received: by wicgb1 with SMTP id gb1so130035638wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UvZDfoWuoiSfaWqI7mBC3Ys/LAKoVmkiKKds8LeVfOM=;
        b=QiWVr9MNMn9BTbUlbFCl6BTB0YToXovC3SlCYfXIKY7yk25HWSxNJoFf8FfkO841I8
         FXPddYpUJaaw4OHOz0toSo2c19zUsCD6eRPnO1V4YG+Oqrs7jr5ucsNOo+YjPWDY0Kii
         J87kwlCSUATRLcmOpAZYuXcn6Dj+4OKDNy/8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=UvZDfoWuoiSfaWqI7mBC3Ys/LAKoVmkiKKds8LeVfOM=;
        b=NuEJW62JOxljgC/deBPRrNGGnr9JSFxQifMwikr9hc5wFCeL0/TzwuAe+kdc43BkMY
         GnOGeeYdj+OM0XOMvGJHCwLLJxi5Ugg4xBIH2ibDLrMSImwbCskH7aTuRj5s0asVj30m
         zFGoDSzPoa7j7z8Wql2ZbeuPmlqfeXNK6+VYQsqWujPU8xEtCMFeZH0AuiskRX4SMafn
         zhx3Tjy4wgqOmvCQk5flHywEUbnCmv3LE0cYUHSddHw+edGnES/I4eZiIDpUXfy6l7gn
         ODccj9L/P/ddKoK4bUe0NAIIF9MJ7QGT+TqDFiGJauYx/UTuBko6cVJpZa13GQ/UgGUP
         JIkQ==
X-Gm-Message-State: ALoCoQmcApFd/u2ba9A72Xgt4VnBObpb0Hmi9v3Jww8BGr+U7KlLHXHsX+QUqeUaI7e5VW1BDg6r
X-Received: by 10.180.91.12 with SMTP id ca12mr15488156wib.4.1442864746289;
        Mon, 21 Sep 2015 12:45:46 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id ki7sm7106578wjc.28.2015.09.21.12.45.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Sep 2015 12:45:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278327>

On 20/09/15 21:26, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v5:
> * remove superfluous flush call (thanks Luke!)
> * keep &&-chain intact in test cases (thanks Luke, Junio and Eric!)
> * add mock LFS test case for deleting files (thanks Luke!)
> * add mock LFS test case for git-p4.largeFileExtensions option
> * add Luke's ACK to commit "git-p4: add optional type specifier to gitConfig reader" (thanks Luke!)
> * replace substring extraction in test case ... "${VAR:X:Y}" only works in bash, "$(echo "$VAR" | cut -cX-Y)" works in sh

Sorry about this, but patch 6 no longer seems to apply cleanly to next 
(or at least not for me).

Luke
