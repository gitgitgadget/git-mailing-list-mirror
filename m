From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/2] log: add --show-linear-break to help see
 non-linear history
Date: Fri, 21 Mar 2014 08:02:30 +0700
Message-ID: <CACsJy8A1XZm1FanJ-QufOHsX44daVSEJA=g7VnA0bYS6uMzNVQ@mail.gmail.com>
References: <1395060676-23144-1-git-send-email-pclouds@gmail.com>
 <1395294254-941-1-git-send-email-pclouds@gmail.com> <1395294254-941-2-git-send-email-pclouds@gmail.com>
 <xmqqha6sy955.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 02:03:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQnra-0000oP-FV
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 02:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966631AbaCUBDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 21:03:05 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:32772 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966417AbaCUBDB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 21:03:01 -0400
Received: by mail-qc0-f176.google.com with SMTP id m20so2027040qcx.21
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 18:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PRC0uY584DlZzHYc+1QyMshQ0DxyPgBGzqGYNBO1VzA=;
        b=z3jcN3ffwSTXK6BH7XgglN74ge7lDWETKqxS/Ds9eKlFPXXpX3WXa7R5/qewlejayP
         xciM773Gn9j7JqwIVTjXuXbbrNh06DJM6N6XIjrKnHBgWWq0iFJnXlKXa+qavEH/KfKN
         19YJxvA/uG4n10nX/zY5QDPi6HPN86rXfV9tkfb4tA7VSTjmbKmd28fXxxrcmFYPRyU2
         7cpJbf6eg31Llq6q3OCkb8k151ssYn5p6I8T9vH7WJ9zg7rndJQN26vQRUsByzMvrEVN
         nVejeVeUuyCk3izn68oawIOVhNxo9654EBqhej2ObBvqmGu3tLJBPdtNNU8+R0TOQiB9
         XQ4g==
X-Received: by 10.140.89.234 with SMTP id v97mr51591250qgd.20.1395363780853;
 Thu, 20 Mar 2014 18:03:00 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Thu, 20 Mar 2014 18:02:30 -0700 (PDT)
In-Reply-To: <xmqqha6sy955.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244626>

On Fri, Mar 21, 2014 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * Get rid of saved_linear, use another flag in struct object instead
>
> I cannot offhand say if I like this change or not.  A flag bit is a
> scarce and limited resource; commit slabs felt more suited for
> implementation of corner case eye-candies.

My thinking was like this:

OK an int for a flag is wasteful and Junio suggested that unsigned
char is used. But that still wastes 7 bits. So what if I rename it to
commit_flags and make it usable as a flag storage for other parts as
well? Wait don't we have some flags in struct object#flags. It turns
out we have _7_ flags left that nobody touches. Let's take one. If we
run out of flags in future, we can bring back commit_flags slab,
rearrange the flags and move rarely used ones to commit_flags.
-- 
Duy
