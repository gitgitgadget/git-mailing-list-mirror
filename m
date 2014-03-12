From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Microproject idea: new OPT_* macros for PARSE_OPT_NONEG
Date: Thu, 13 Mar 2014 06:37:41 +0700
Message-ID: <CACsJy8Dw=43m_4KzAxwCqLsFq2E23rT=bT3zmGUue6RYTnrOYg@mail.gmail.com>
References: <CACsJy8CBVVJN3V8N_djLF4XKfTbxvdcJCnWmZJxVZOwy8AMQWA@mail.gmail.com>
 <531977AF.4060907@alum.mit.edu> <CACsJy8AUhHE8=Yaj6_G46V6w5ZbA3z403GkBfsbZL7MxgeA3RQ@mail.gmail.com>
 <xmqqzjl1u87n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:38:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNsj9-0002vi-5X
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 00:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbaCLXiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 19:38:13 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:62628 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbaCLXiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 19:38:11 -0400
Received: by mail-qc0-f180.google.com with SMTP id x3so300756qcv.11
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ysDxwbTsKe8/9VoUnaBmb/ZWOpZBFurmXXzT3jBDuSw=;
        b=Rca7DmNyzyrmu3YYh4HWZE1rTfYx2rUq3MFeCluFyDjICmN+hf8jnXQkuWhida7ozB
         DOCX1CPG/l+/6blD/LgH+k7Rsdn7W125xX/g371tigi1HwdyUZTKE3lV6JdIh8BtBAGW
         Ii3CDouItpODDLZ1FJLtZZB6hwhR1EM49mr9GY+uG2y4aoH6xPM0SuhExtZeVyZxwkad
         nuLJSng+fwbiU4xZVOHxoJ4N4zNMLvCX/DmbAa+U+hkA5ZU+5SfWuVsOKXzaVuFXihZw
         QZ8eK+X4hNbB9S6sX4x6/CQzbDqsS/vWjTqt/aRcBFn6kOR17jjc0oFCK0zjsK8eNiZL
         aDAA==
X-Received: by 10.140.83.203 with SMTP id j69mr359388qgd.42.1394667491211;
 Wed, 12 Mar 2014 16:38:11 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Wed, 12 Mar 2014 16:37:41 -0700 (PDT)
In-Reply-To: <xmqqzjl1u87n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244009>

On Sat, Mar 8, 2014 at 2:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Looking at "git grep -B3 OPT_NONEG" output, it seems that NONEG is
> associated mostly with OPTION_CALLBACK and OPTION_SET_INT in the
> existing code.
>
> Perhaps OPT_SET_INT should default to not just OPT_NOARG but also
> OPT_NONEG?

There are OPT_SET_INT() that should not have NONEG in current code. So
there are two sets of SET_INT anyway. Either we convert them all to a
new macro that takes an extra flag, or we add OPT_SET_INT_NONEG() that
covers one set and leave the other set alone.

> I have a suspition that most users of other OPT_SET_<TYPE>
> short-hands may also want them to default to NONEG (and the rare
> ones that want to allow "--no-value-of-this-type=Heh" for some
> reason to use the fully spelled form).  IIRC NONEG is relatively a
> new addition, and many existing OPT_STRING() may predate it.

I haven't checked how NONEG affects other types. But that's something
I should probably look into.
-- 
Duy
