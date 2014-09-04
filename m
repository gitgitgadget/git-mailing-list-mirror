From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] gc --auto: do not run 'pack-refs' and 'reflog expire' twice
Date: Thu, 4 Sep 2014 21:13:44 +0700
Message-ID: <CACsJy8AY_hXMH+ML9SUm_89ykWDOMvB2XThVkaq5Aufes8=5AQ@mail.gmail.com>
References: <1409459610-8695-1-git-send-email-pclouds@gmail.com>
 <xmqqzjeh28p0.fsf@gitster.dls.corp.google.com> <xmqqtx4pzvcp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 16:14:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPXo4-0006cv-If
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 16:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbaIDOOP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 10:14:15 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62757 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaIDOOO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 10:14:14 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so11788250iec.18
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gnhw6sj+2PVwHf4ZO5iG0OSGwoH2lLSDI7ssqo7SZD8=;
        b=YU71letvFcm1R4ZgNBg4KRiFzZrUo1hslInrYE+GajcRlRElffqYcJJyprkPykYSKf
         6qn9vzwZsFMRINo3lt4zinScnqnQePCuSrTCRBRJuQwcK94xeqsQLE1S8s7mzDaVRC4X
         i3UunabA7vyUUph70TWiU1y8S/u3onyIp4QYQVOGGetjg8jyexJ8dxj72q1Zu2VmA7mn
         CUF8fAHggDiGSVz5+CT4JDYEx4KwEm4uh+W8Y6VZtu2c55W8g1jPUfOjmHg7BrrQTR4M
         8MiTnz56nGAc4et6cU8chT/TNpVxkOeE6HEvAs9N0UqrMsv3NytkMIbIRCapYkchIKHw
         km9w==
X-Received: by 10.50.43.164 with SMTP id x4mr7427459igl.27.1409840054263; Thu,
 04 Sep 2014 07:14:14 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Thu, 4 Sep 2014 07:13:44 -0700 (PDT)
In-Reply-To: <xmqqtx4pzvcp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256445>

On Wed, Sep 3, 2014 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> In the --auto code path, gc_before_repack() is called once in paren=
t
>>> process then again in the forked process. Stop the second run.
>>
>> Hmph.  Is the true reason why this happens because we have two calls
>> to gc_before_repack() in the main, and one is before daemonize()?
>> Shouldn't this protection be in the caller?
>
> Actually, I think the function already is protecting wastage of
> getting called twice by saying "I've done pack-refs already" and
> "I've done prune-reflogs already" by setting the two variables to
> zero.  Isn't that sufficient?
>
> What problem is this patch trying to fix?

Oops. I missed that (and should have verified the problem in the first
place). Sorry for the noise.
--=20
Duy
