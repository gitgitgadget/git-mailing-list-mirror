From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] gc: reject if another gc is running, unless --force is given
Date: Fri, 9 Aug 2013 19:52:49 +0700
Message-ID: <CACsJy8DRRLkyZid_OPSvRkvKfnd62TnLBnaueim9GrXUikPGuw@mail.gmail.com>
References: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
 <1375959938-6395-1-git-send-email-pclouds@gmail.com> <7vk3jw9hlm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 14:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7mC4-000411-LM
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 14:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355Ab3HIMxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 08:53:21 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:49004 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab3HIMxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 08:53:20 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so6437316obc.10
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pfo9cS/pJl4BiqgyYEt0y6jjvj7++aJEhN6F4M7jYtY=;
        b=cZW6jhEQvCF437/twpJQZzK3KGoo+N6mf8snAwsw6/9R1gVpMzmWZNuvMHnrvvslZs
         qVE4l8myWj4o2ztISzzmFmQB1AR0Mv3DQhskdlvG48NBR+7mtl0CMLSDoI1P7X4pWdof
         a3tb+fsWLeeSKIlhTcIiZKHw2dh7L92c7Vskt/NiYf46ELcZIKI+Nh6mXPNovUCBxcqq
         i6GXdwBi97vPpRxQ2BafD7ekM6T1vqxjikSYcJUWz92bDwFHgpE4+cIoPk4cfKePmX54
         kF/DdxRn+2OnpCJVokhFlTFyqF3HETuyuCTCpXP2nLj9WlA+PN4mCxMWx9bqumElxg8j
         lx2Q==
X-Received: by 10.60.34.4 with SMTP id v4mr394013oei.101.1376052799691; Fri,
 09 Aug 2013 05:53:19 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 9 Aug 2013 05:52:49 -0700 (PDT)
In-Reply-To: <7vk3jw9hlm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231976>

On Fri, Aug 9, 2013 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> When we see a recent lockfile created by a "gc" running elsewhere,
> we do not set "should_exit".  Is that a good thing?  I am wondering
> if the last two lines should be:
>
> -       !strcmp(locking_host, my_host) &&
> -       !kill(pid, 0);
> +       (strcmp(locking_host, my_host) || !kill(pid, 0));
>
> instead.

Yes I think it should (we still have the 12-hour check to override
stale locks anyway). Should I send another patch or you do it yourself
(seeing that you have this chunk pasted here, you might have it saved
somewhere already)
-- 
Duy
