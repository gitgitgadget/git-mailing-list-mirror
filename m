From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Thu, 25 Feb 2016 15:50:23 -0800
Message-ID: <20160225235023.GW28749@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com,
	peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:50:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5fz-0000g5-B8
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbcBYXu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:50:27 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34583 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcBYXu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:50:26 -0500
Received: by mail-pf0-f182.google.com with SMTP id x65so41143058pfb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=l0BIzdJsbpubnADh+TTK6YBai0fkwptNRmIEiNjFZHY=;
        b=UMnVVTf8r4YlkSoMe7tdDOqiohIdn04H0eaJE3iZG5SnW4CjuNDbZoWHMplf+91nk7
         0Ha0Qqtg+bMt/kiIzPVl3tm2K6R7UewuxIPX44pFhRhFRz6yD3UenuxXmJJ8swzK92vx
         xiD0EPnYpdh3sUq30XLGntZ28FMY2YiJf5+HqgFTHczl2WmRtom/UqMgKF+sIFEzQPMt
         UPx1oFQFgfh0FSumeKSnor07gndnnKDf5ExpDNzvtGZD9a9YTva/+VrNdVu2VG5/tK67
         GRSGfMY+0xUqo2rT/DDk2k628gDcb5gNcrpaD1LmLAL2UKD1gTwh2NxTjft06g/gUkrR
         7ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=l0BIzdJsbpubnADh+TTK6YBai0fkwptNRmIEiNjFZHY=;
        b=nDcVV6kxCa4meqHK1qg2cdEtjeUS8UqGZxWDEEyOMZGVmVEltqvcbzlV+w7QHY4ULB
         Aqai+iu5PMJC34XHr6ijwREf7izB2q9JvPHdcASwy0lt7O5A0K4rFuYm10dlrZmeMDbB
         ZmGpyrOoYKmGursmIgsi/Cu42vQ2M2Q7Tf0KtG7hzPPaR42umpNof2OpRq19aSeuiigJ
         TOede2BmaqQ86OR14S2v2j0FeLZBibgBR0uwZxZxjtwGkRBbMEzK+y/qUb50vB9yox2t
         TbVvvhh3asYor/+9DQsfvhyABO8v0qTo/ffaGlHOqKKbmC3oYfbJ1v1TF9/ywiNyS9+W
         fyqg==
X-Gm-Message-State: AG10YOQcMXqiU09VUaQ2HgTflOW70WmDamkEbTdj1mDG/4MWSUGQE/YQnZNcqbOByk9FsA==
X-Received: by 10.98.18.215 with SMTP id 84mr66861922pfs.131.1456444226042;
        Thu, 25 Feb 2016 15:50:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d4a8:9152:117:98a9])
        by smtp.gmail.com with ESMTPSA id r87sm14598843pfa.61.2016.02.25.15.50.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 15:50:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287509>

Stefan Beller wrote:

> Thanks Jonathan (and all the other cc'd reviewers) for bearing
> yet another revision!

Thanks.  This one looks good.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
