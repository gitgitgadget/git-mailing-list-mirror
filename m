From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add "list" and "rm" sub commands to tg-depend
Date: Thu, 9 Apr 2009 20:01:04 +0200
Message-ID: <36ca99e90904091101l6dd1685y5be70dd77bf52b57@mail.gmail.com>
References: <20090407133329.57b06727.weiny2@llnl.gov>
	 <20090408080824.GF8940@machine.or.cz>
	 <20090408083955.GA28482@pengutronix.de>
	 <20090408091949.8a648d83.weiny2@llnl.gov>
	 <20090409124337.GA6034@pengutronix.de>
	 <20090409091021.5a7ded79.weiny2@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Brian Behlendorf <behlendorf1@llnl.gov>,
	Git Mailing List <git@vger.kernel.org>
To: Ira Weiny <weiny2@llnl.gov>
X-From: git-owner@vger.kernel.org Thu Apr 09 20:02:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LryaM-0006CK-5M
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 20:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764485AbZDISBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 14:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762129AbZDISBI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 14:01:08 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:37679 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760466AbZDISBG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 14:01:06 -0400
Received: by bwz17 with SMTP id 17so709896bwz.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WE5rljYmQBeswW6zTszFjBov9l3aWf2bOE926BmXPzE=;
        b=e1+hf2Fy6XfBqy2fvSrhaNFcog+EUyEFAqqp+5LIr87wNGM0VUrmDDORRtKcsX/QXT
         vIBHEJ4OCWr/A8hPMudmErpQwHkaE6zGIvw+1iDOCFURxgluG53Oe2wj0YY/o7O0CqQR
         toJFoCSUMubXz6MU4wg0OFmZ6uFhsRjJF/KP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=glosDNHmjep++tuhe/YjlmLnPeBNWr44jpjVjSOKk9rzTFD9onx4K/Ibw/UVOASw5F
         xLOa/MUiJMVhWOBYJdhRvlpBdIM1TQfGLEalWWzd3aMLA8KyEJrBLZSfM0hhEVvA/zA5
         YWZ6NnXf37ts+OxvWpBJlYeKIIdi9pe+mWlmQ=
Received: by 10.223.116.205 with SMTP id n13mr851690faq.103.1239300064098; 
	Thu, 09 Apr 2009 11:01:04 -0700 (PDT)
In-Reply-To: <20090409091021.5a7ded79.weiny2@llnl.gov>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116193>

2009/4/9 Ira Weiny <weiny2@llnl.gov>:
> On Thu, 9 Apr 2009 14:43:37 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>> You might want to check
>>
>> =C2=A0 =C2=A0 =C2=A0 http:// thread.gmane.org/gmane.comp.version-con=
trol.git/114581
>
> Ah this brings up more issues I had not thought about... =C2=A0:-( =C2=
=A0But perhaps
> Bert's work could be used to help implement "rm". =C2=A0Thoughts?
No, it wont help. Because the base and tip of the topic should not
changed in respect to the old state (expect for .topdeps of course).

If you really want to remove a dependency, you need to revert a merge
of this dep from the topic base. which is not possible today, or maybe
I have just an idea for this:

  'topic': the topic
  'base':  the base of the topic, i.e. a merge from all dependent
topics dep0, ..., depN

say you want to remove dep0

  1) merge all deps dep1, ..,depN into 'new-base'

  2) merge 'new-base' into base with the merge driver 'theirs', that
would overwrite all changes from dep0 in the 'base'

  3) update 'topic' to the updated 'base'

Any thoughts from someone who knows more than me?

Bert

> Thanks,
> Ira
