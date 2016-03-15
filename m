From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] submodule-config: use hashmap_iter_first()
Date: Tue, 15 Mar 2016 15:30:07 -0400
Message-ID: <CAPig+cRJKsdkGEr-_Z7pxKW-t9X45+Z4ZLzgk=aprMHMdmLNqg@mail.gmail.com>
References: <1458069195-20888-1-git-send-email-kuleshovmail@gmail.com>
	<CAGZ79kZ_wbJ2MGs_E-P_0eLk3JX_0QhT1c_BxqWCS+vrg8+xwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:30:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afufW-000761-KL
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934905AbcCOTaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:30:11 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33355 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbcCOTaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:30:09 -0400
Received: by mail-vk0-f43.google.com with SMTP id k1so34386164vkb.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pr9+xRPfE9C/rc6fMLR8T2D69Bzvjr8jG6HUhdPW5IE=;
        b=xYsSTXaAbjoh6jfogjHcoIO5sxU+hOeIFmbE1vYTKa8fKOkzSltoAwtmWqTmNxYFcQ
         NMU1v5uipKxtMTCto1cAF31PsbOJei/TtnMwSUr4OBo5NdzCe/1xgcScTLX+Cz9Dpx3W
         BgMgJYncK0c3GbNJ5UiMqqPoj2vhOfHoUo2z1xYuMfZxQdsstJga9Yrqfnb2RtpeMoUO
         sQDepCeTn/UtAYi7HghJOjOzGO5AmXGrZ1btBu9kGbyWhpvOvhds4TI7Q+4cf6eEAKHW
         2D925vKW1AoNE58BWDCtyh8TH8iTgIstTpUQYy8izNZOjemhkfKA+pAA3A7ApXa4qTK5
         31iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pr9+xRPfE9C/rc6fMLR8T2D69Bzvjr8jG6HUhdPW5IE=;
        b=mW1jiYf52qBpb+oBVAXxyojYjdo4gtFTP9WVJHw094LpzcrBYIk+WEFPBUZuYmoKVO
         KX9QisMuF6QTdjoFmVtAXsA9vKDck4pwHUatD4r24NzolUC3w+q4+DcUcsv3OHq73rNM
         PQwev+y1LluiDekmP4xPU6s60qIwLpHxxBDSRQuFZ8q66k1qOkNtadtrNMLDnzDAwE6z
         2FGs2MoS1aiYu3OuNpoNVW1FWDaK/s5PCtxuOvkqG4xzCRmdU7ivcPIu/BNRIM22mAPc
         Nu8ulogmqkhJmeVmZMXcnlDc57i0nHxUIQrI7xlZDfEw7qEBAR+8qvgOTu+v228xnsAh
         AUGQ==
X-Gm-Message-State: AD7BkJIhvJkra2WDlxb0b5YAwhA6uPTZA6nuAWBFhBfDlD351Ye/66X81RHUtXHdvsX4GaE5+opHSDTzf7AOgQ==
X-Received: by 10.31.182.143 with SMTP id g137mr33120302vkf.45.1458070208058;
 Tue, 15 Mar 2016 12:30:08 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 15 Mar 2016 12:30:07 -0700 (PDT)
In-Reply-To: <CAGZ79kZ_wbJ2MGs_E-P_0eLk3JX_0QhT1c_BxqWCS+vrg8+xwA@mail.gmail.com>
X-Google-Sender-Auth: WoO0cYTLxzkICc9e1QL4VnQuh6c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288898>

On Tue, Mar 15, 2016 at 3:21 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Mar 15, 2016 at 12:13 PM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> from the <hashmap.h> for simplification.
>
> I think what Eric wanted to point out, was to not have a continuous sentence
> from commit message header to body.

Yes, thanks for clarifying that.

> Either leave the body blank (as it is obvious) or write a whole sentence there:
>
>   [PATCH v2] submodule-config: use hashmap_iter_first()
>
>   The hashmap API offers the `hashmap_iter_first` function as initializing and
>   getting the first entry is a common pattern. Use that instead of
> doing initialization
>   by hand and then get the first entry.
