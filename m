From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/23] Preliminary pack v4 support
Date: Wed, 28 Aug 2013 10:06:49 +0700
Message-ID: <CACsJy8DAeeUrkUw6A28suLq4VoHjt-k3Wd8SLHWcjxr85A0c2g@mail.gmail.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <xmqqioyrfa5m.fsf@gitster.dls.corp.google.com> <alpine.LFD.2.03.1308271153370.14472@syhkavp.arg>
 <xmqq8uzndqws.fsf@gitster.dls.corp.google.com> <CACsJy8AttNxePUG9cKw9ihAmRd=kFpcsgwe2yj_FRQbhc-akCg@mail.gmail.com>
 <alpine.LFD.2.03.1308272241470.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Aug 28 05:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEW6Q-0003UZ-Su
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 05:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab3H1DHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 23:07:21 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:52862 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab3H1DHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 23:07:20 -0400
Received: by mail-oa0-f44.google.com with SMTP id l17so2432875oag.17
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 20:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=66RzLJfETdd+IvZ6f7vpgdNLP1qIQ7H+HId7re+9CjQ=;
        b=VgnW6qwqgdid0HWP6VcNA7I7ZgggQg8hVEO3Awtu5yWqYQzSsSPKM5xAHGJhpQGQRM
         Hx+Tt07kEkWV0YDhTfUXcLNqFGwAeCrhMvHIDkKuat1+eF48dUP4Fs4vnxwbRmqhzmhj
         CDUB/2ToZfVZgtVa5eJL2F2W0Apdc9IpNUENXGGmwdXPetI/M3Ue2oY9MvVU0R3zNz4j
         nqjn+UTpWR6LCVs7bR+GBcXoNG2jQ2w4Dr7NsAwcmn4/AU3iLK1Y7c/kWfMtnCWuqRzo
         zRF9EojXz8niYTzfitRAtmFLWfywo01UJwO1yedC1162vcywH83tJRxY+oLXR2TfXVUf
         Flgw==
X-Received: by 10.182.81.65 with SMTP id y1mr4929499obx.89.1377659240020; Tue,
 27 Aug 2013 20:07:20 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 27 Aug 2013 20:06:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1308272241470.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233176>

On Wed, Aug 28, 2013 at 9:58 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> But what if we store
>> appended objects in OBJ_REF_DELTA format where base ref is empty
>> tree/commit and cached by sha1_file.c?
>
> I don't follow you here.  Missing objects need to be added to the pack,
> they can't be cached anywhere.

I use ref-delta as an alternate escape hatch to store missing commits
and trees in unparsed format. In order to do that, I need a base ref
SHA-1 and we can create and store SHA-1 of empty commit and emptry
tree in sha1_file.c (because empty commit is not in a valid format and
can't be parsed and stored in v3). So the result pack is still "thin"
but it should only lack at most two objects: empty commit and empty
tree. Thinking again this is much uglier than escape hatches to v3
tables..
-- 
Duy
