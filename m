From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 07/12] MINGW: config.mak.uname: reorganize MINGW settings
Date: Mon, 28 Apr 2014 17:17:25 +0200
Message-ID: <CABPQNSa7buDJFYsaW1a51XoRnqZiVUYGSgfS1t-UiF7TnuWX5g@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-8-git-send-email-marat@slonopotamus.org>
 <CABPQNSb_+hrm-avwx4Y1749C_Ak4VN5KKvso3LeFcdDPcbqS5w@mail.gmail.com> <20140428150436.GB19002@seldon>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenJx-00052a-Pj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954AbaD1PSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:18:10 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:46776 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952AbaD1PSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:18:06 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so4890090igq.13
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/vGSn3KTcTaVTHz5ZVxwNEmfaJRUO3iqCY/QhQMlwVs=;
        b=UxWWyCB4dlrOXByLsqyPF3KqDq8IHlyEGq98N+BP4tfZ/D8a5nTqRzJ3Ir5XujA/3l
         v2PTpdsFPbjPJITG8ScsPdOA077T9fwtpUQsGYTP4mRR3g2GNHF4DI2ieZB3+1NxB4WN
         OATWRVUIUtOl2BJ2s6tQoY7G9ry4wL+7DawXxDJ7NM9GchS88dr/7aIArPDosZ4Uhe55
         7kvj5Dp/ycOS8Jd0BGlfi1z20Tl2aWIOkXnqgFhXGv2J4XYTvCBYECIQuH+YZ29kTo5S
         NSFsMhtUXIuQN9FV7hHaWIB8zPUddF4n4A4L6CozKkLqH8aFLkpRQM8k4h/AefN75g8x
         HTlg==
X-Received: by 10.50.36.66 with SMTP id o2mr24389183igj.24.1398698285822; Mon,
 28 Apr 2014 08:18:05 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:17:25 -0700 (PDT)
In-Reply-To: <20140428150436.GB19002@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247357>

On Mon, Apr 28, 2014 at 5:04 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> On Mon, Apr 28, 2014 at 04:58:11PM +0200, Erik Faye-Lund wrote:
>> On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
>> > HAVE_LIBCHARSET_H and NO_R_TO_GCC_LINKER are not specific to
>> > msysGit, they're general MinGW settings.
>>
>> Actually, HAVE_LIBCHARSET_H is. It's only present because we have
>> libiconv installed.
>
> 1. What are other ways to provide iconv on MinGW?

I'm not sure I understand. To set HAVE_LIBCHARSET_H, we need to have
libcharset.h. MinGW doesn't supply by default to my knowledge, so we
get it from iconv. The THIS_IS_MSYSGIT file is there for us to be able
to pick the right defaults for msysGit, and us having libcharset is
indeed a msysGit-detail. Not all iconv-flavors supply libcharset.h, so
this tells a particularity about the one we have in msysGit.

> 2. One can still completely disable iconv with NO_ICONV=1

Sure. And it does seem like the current setup assumes that anyone
building for MinGW has iconv. But perhaps that's a mistake?

All in all, I think maybe the line between MinGW and msysGit is a bit
blurry at the moment. On the other hand, I don't know of anyone else
than Sebastian that builds outside of msysGit.

To be honest, I think the whole THIS_IS_MSYSGIT-block should have
stayed downstream.
