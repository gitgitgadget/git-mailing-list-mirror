From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 9 Aug 2013 23:55:18 +0200
Message-ID: <CALWbr2zx7eU_SmGT1MmPvYhbmU3v8y4LxopeBAefFkUBnbRtew@mail.gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<7vfvui4jy8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 23:55:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uee-0000f4-Kt
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031271Ab3HIVzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:55:20 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:46118 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031243Ab3HIVzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:55:19 -0400
Received: by mail-qc0-f179.google.com with SMTP id n10so2489938qcx.10
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3kAzIuXUQqo+WIKHHEa/Jg0oh5t65F1FPt4wRvYYAOU=;
        b=cM0N0YooQuc4Ua/DPBhAO9eYgLCQp8QxetQSNF9HfhUzNQVmOpcB6gxM3y0kxwVKKr
         kamayaDPud0DpmlK/Y3VWHisDF9dc4EP76YblzDAaK1uE8jgWO1RxDvnu5jdpaQTW4pj
         /OqfuCQzupmcByAnbMIOTQou92HU4c+GSiX+0E/1ME3J0xvvhQQUtMyNJ0/ef3BuVRUB
         e/PaHzk9iRDKDYWdY8/cLwBUFPXatD7Z0U+3d1BSyVEiUIPIQHR5qhOOzmo893j2In7Z
         vMPb9c6BbWVgMliyBj8zSDeLr9kLrPZsdTp9sfQzLppXp02MELyoA4MChJr2bbD4IVvB
         tGdw==
X-Received: by 10.49.30.233 with SMTP id v9mr2727415qeh.96.1376085318398; Fri,
 09 Aug 2013 14:55:18 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Fri, 9 Aug 2013 14:55:18 -0700 (PDT)
In-Reply-To: <7vfvui4jy8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232042>

On Fri, Aug 9, 2013 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OK, so clone works, but subsequent fetch from the cloned resoitory
> does not?  "git fetch hg::~/my_repo" will still work but the call to
> "git config" done near the place your patch touches does not store
> "hg::~/my_repo" because it thinks "~/my_repo" refers to
> "./~/my_repo" and tries to come up with an absolute path.  The patch
> tries to notice this case and return without rewriting, so that
> remote.*.url is kept as "hg::~/my_repo".
>
> Assuming that I am following your reasoning so far, I think I can
> agree with the patch (not that my agreement matters that much, as
> you seem to be a lot more familiar with this codepath).
>
> Thanks for explaining.

Thanks
