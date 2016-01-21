From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/15] ref-filter: introduce struct used_atom
Date: Thu, 21 Jan 2016 14:04:52 -0500
Message-ID: <CAPig+cSRDhbHmn5NSp_S4J99igFhBEpWfVMBKBDHCWAHN7-8qQ@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 20:05:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMKXV-0007FC-4u
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 20:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965674AbcAUTE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 14:04:57 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33325 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965662AbcAUTEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 14:04:53 -0500
Received: by mail-vk0-f65.google.com with SMTP id n1so2094692vkb.0
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uR2MpuLpg0vt+vfXDIUYTWusbLkDHXj1UeG6Oj4QZPY=;
        b=ahdluL4jL8iyHO7/PP5XJa+uznuD/+TUSCC7/WWRb3cy4aqoHaP+fxYLMOjSo97NNw
         TsZmCxT2kURmRwTFvrd6cc6LFcLyVt485vhphlzt+hDbbKaNJM5eFzPLuuHrWuZmLizC
         EYZAKk7uwr+Gm9c7DalPu+HkKKmlHSbPIaqpGGB79BQWpHDiFBjaLC5e/P8sI1x7bIMh
         yX+Wk1SQ+w4e1FMBZ5uOwBNZKwAJyUwWFJh4eyBAz5+74Hs/bei/Qs7mx4rqCjK3aXej
         F3x0lDUKVwbUBHsyYkGZkHLJdiyU+3ST4nzxt0uSKkF/MZCnuZqkCN+oooUjfpz5G/zC
         s8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uR2MpuLpg0vt+vfXDIUYTWusbLkDHXj1UeG6Oj4QZPY=;
        b=LaZyH6y48OU4w7KZbzppAOVVL3eOQEIhOsBIM6OVImDhtA7pc0KHzjroaS/Cx5YvC3
         J2+5lCSA47g52NtETNdSLIliiezT/zslVWKEkkLJ57XKVsdgSs4XQtNEfBJI6t9FBxzx
         0p6MG+79/FYgiZPBNLFfdw9AAenbK4GTiMZ9hJM7ySI70fe5C5RGqyHPRpC/l5uIKTaq
         xkez4wd+mWmVy3YAy40VJtHvllTGTCjMqM7KPnthQ6fsMmVRpTgVrwDtPM/jwBDnTBwl
         BX7vOkJgf0WgC9c3IARJU7St/PSymKNivLd3NtX3RBH/y54tqWpOx9en4pXYkrjQZ3/g
         rXvA==
X-Gm-Message-State: ALoCoQl344iW8ICsKZB5PQqT0AQRbcjf045ALYMdUxb2gYE9ioPyjhHzEQ6hskfayS5XCd659ERR+zMtMbpgGZeouByNOZ6Eyg==
X-Received: by 10.31.150.76 with SMTP id y73mr29634385vkd.84.1453403092150;
 Thu, 21 Jan 2016 11:04:52 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 21 Jan 2016 11:04:52 -0800 (PST)
In-Reply-To: <1451980994-26865-5-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: ROaVgalwJ1oKCIj0I6miL6NV6Pw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284518>

On Tuesday, January 5, 2016, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce the 'used_atom' structure to replace the existing
> implementation of 'used_atom' (which is a list of atoms). This helps
> us parse atoms beforehand and store required details into the
> 'used_atom' for future usage.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -17,7 +17,7 @@
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>
>  /*
> - * An atom is a valid field atom listed above, possibly prefixed with
> + * An atom is a valid field atom listed below, possibly prefixed with

This particular change should be in patch 3/15 which moved this comment block.

(Yes, it's true that this will make the patch something other than
"pure code movement", but this change keeps the moved block logically
consistent and that it's an appropriate thing to do -- plus it's quite
minor.)

>   * a "*" to denote deref_tag().
>   *
>   * We parse given format string and sort specifiers, and make a list
