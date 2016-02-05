From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/25] fetch-pack: use a separate flag for fetch in
 deepening mode
Date: Thu, 4 Feb 2016 23:13:26 -0500
Message-ID: <CAPig+cRC0YaBMjqNd9OXoU5AUke73GoB7cstxyK9nNbU=kZXaA@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 05:13:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRXlz-00067l-O4
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 05:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbcBEEN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 23:13:28 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36468 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbcBEEN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 23:13:27 -0500
Received: by mail-vk0-f66.google.com with SMTP id e64so2187802vkg.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 20:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ujpRKy+R+sCH9IS0XTddmpMpcLxU0dfqDS55zMkHlF0=;
        b=BkwToM9DIfhp4fueYxE0vVLTOrpB4jPRriv76HMCnyWmKLNnlpXMEJIQxv/ZVWbDA0
         QCPkbzQgy0o7SZ53RznzdtRH6WXmoKdL6Wuxbx1biC9Y1JDO9vLm/wnsdsUC9iCW4GXe
         R711wpbt+cFzg7ArgQMEgXxq3rhyCr4oLl5oWMq0vuqrwRdJ21Gy39/AQLs4taCTWrH9
         esILRDBevuJQOFsEmp1SV5bNWSrDkG6lBkWfA/SkjluHnKwlxYFLqB0jBNDG45A01M1k
         xrq3FMFQwAIs4oN3xWNkOVbaGOwdnPZiTZvIABCGdwHZOw5sx8HS5OZLkUWIMjKg1iGn
         16dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ujpRKy+R+sCH9IS0XTddmpMpcLxU0dfqDS55zMkHlF0=;
        b=OzMsJI9ESNXkR5iljTPpIc2rwjuS8qNXvPu+smEoicMV4dZWXGKCk6nJLVCcr9XYdk
         76jcGfjzCEzMW+r2ZozhNyhO+2ZBVb8nM1tlvCDlgeQvcQ5dG3GVt+CpuNIolXQgLZDH
         jDz/hf9S2t9XUCaLLZPNtEosq2z/kM2CgVB3pZWwPsVtav/n63QIeKYgBzbYXVpzaE8O
         OaivoCHlQIwJa0jTUut2Pb/+Zo4wns3ko+ONxfLbfxLsDWxWoOGw1OH2T1eSArn2IRHc
         YGiiuxAv7nFPWSxDPwCO0g7W0TPOcGyl5ktwC6rtt5Q94X4+Syr29mgHLMG2DcJ/CrjM
         Sa9g==
X-Gm-Message-State: AG10YOSUDjfWznm/35Xq/6JqqnsPZNuhQlH4GotHMCbyyXwb8a2zn8ns/H3i5kAsXaz8Qp85QuCjyed52ML2TA==
X-Received: by 10.31.182.143 with SMTP id g137mr8027602vkf.45.1454645606534;
 Thu, 04 Feb 2016 20:13:26 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 20:13:26 -0800 (PST)
In-Reply-To: <1454576641-29615-14-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: uFhmo1PGulp3Xgb1iHiQ41T07OM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285537>

On Thu, Feb 4, 2016 at 4:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> The shallow repo could be deepened or shortened when then user gives

s/then/the/

> --depth. But in future that won't be the only way to deepen/shorten a
> repo. Stop relying on args->depth in this mode. Future deepening
> methods can simply set this flag on instead of updating all these if
> expressions.
>
> The new name "deepen" was chosen after the command to define shallow
> boundary in pack protocol. New commands also follow this tradition.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
