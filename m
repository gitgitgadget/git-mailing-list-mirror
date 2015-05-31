From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Sun, 31 May 2015 14:42:37 +0530
Message-ID: <556AD085.7080104@gmail.com>
References: <5569EF77.4010300@gmail.com> <1433008411-8550-8-git-send-email-karthik.188@gmail.com> <CAPig+cR88O=STcJDrB+96uJ0Y60mO49QxoJfbOY8Xk4hPvNxGA@mail.gmail.com> <556AC40C.5020205@gmail.com> <CAPig+cRF7VEqqBWJY_GRVL+8YCfrD-mYJ2idN1yzVE7JKeTpwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 31 11:12:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyzIg-0003Qa-V6
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 11:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbbEaJMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 05:12:45 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35787 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbEaJMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 05:12:42 -0400
Received: by padjw17 with SMTP id jw17so16296067pad.2
        for <git@vger.kernel.org>; Sun, 31 May 2015 02:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=v9hXTYIpBwikDHY1p3m7435atbiv9pQy+W+BRceB/eM=;
        b=SwQqFWE7V/qEN69pef4p9Sjnb4Tj71SCzJWpQrT5ZoB4Kt77kD0nO+5aEji/pRQTXD
         WByQ+fQ3lmJlwGH+QjuvR690MLXEg6PR8bqHrapO0jGeL6G68rWnoWaR77Zg9FdDX/1A
         y+V9vkTqH3+WajN+2Hsj+xcgu3FrUEudJ+fUtTU6q00Vs8R4olRMhffTwGO7s9gsY8v3
         w4zdDr+QvhmTj8ucoQ1oED3kZVx7FKf64VVEtNxZGz5L6JYlBhegS+21NZxsfge/O7oo
         vF1sg9bzSjw+7+VulPst40QkSW1FP/AIJNrEUid4tjEJmKw0i8Wi7IV9JETGR0GrfPWq
         5bFA==
X-Received: by 10.68.65.76 with SMTP id v12mr30620796pbs.104.1433063561969;
        Sun, 31 May 2015 02:12:41 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id bs4sm10803674pdb.21.2015.05.31.02.12.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 02:12:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cRF7VEqqBWJY_GRVL+8YCfrD-mYJ2idN1yzVE7JKeTpwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270326>

On 05/31/2015 01:59 PM, Eric Sunshine wrote:
> On Sun, May 31, 2015 at 4:19 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > On 05/31/2015 09:13 AM, Eric Sunshine wrote:
> >> On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com>
> >> wrote:
> >>>
> >>> Create 'ref-filter.h', also add ref-filter to the Makefile.
> >>> This completes movement of creation of 'ref-filter' from
> >>> 'for-each-ref'.
> >>
> >> It's important that the project can be built successfully and function
> >> correctly at each stage of a patch series. Unfortunately, the way this
> >> series is organized, the build breaks after application of patch 7/8
> >> since for-each-ref.c is trying to access functionality which was moved
> >> to ref-filter.c, but there is no header at that stage which advertises
> >> the functionality. Fixing this may be as simple as swapping patches
> >> 7/8 and 8/8, along with whatever minor adjustments they might need to
> >> keep them sane. (The alternative would be to combine patches 7/8 and
> >> 8/8, however, Matthieu didn't seem to favor that approach[1].)
> >
> > That is kind of a problem, If I need to swap those commits also, I'd have to
> > add the part where ref-filter is added to the Makefile with the code
> > movement from for-each-ref to ref-filter. This again will not just be Code
> > movement.
> > But I guess thats a fair trade-off, will change it. Thanks
>
> Don't take the "code movement-only" recommendation too literally. What
> people mean is that you shouldn't make changes to the lines you're
> moving from one location to another (other than absolutely mandatory
> changes to support the movement) since it's difficult to spot and
> review changes in lines which are being moved.
>
> The recommendation is not saying that the patch itself can't include
> any other changes (though, it's often best to minimize other changes
> in the same patch). In this case, the Makefile change is logically
> related to that particular code movement, so it's correct to include
> it in the patch. (Also, the Makefile change is so minor that it's not
> a burden upon reviewers.)
>
Thanks for clearing it up.

-- 
Regards,
Karthik
