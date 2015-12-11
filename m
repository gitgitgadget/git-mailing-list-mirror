From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCHv2] Makefile: add missing phony target
Date: Fri, 11 Dec 2015 16:13:11 +0100
Message-ID: <CA+EOSB=a-qWP2-UfYJjPjSr8DD1ER39_rJPc8HAxV5qr+gw1qw@mail.gmail.com>
References: <1449843766-41658-1-git-send-email-gitter.spiros@gmail.com>
	<vpq7fkl3v66.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Dec 11 16:13:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7PNn-00023x-FK
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 16:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbbLKPNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 10:13:14 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34546 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbbLKPNM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 10:13:12 -0500
Received: by vkgj66 with SMTP id j66so21135490vkg.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 07:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SjVHlI5O1GzTmqiINT0u+nNgVibzlq2WmrLmnkXCS5U=;
        b=dbyH+ixssCjav7Vse0ad3nWwCCbjk5B9CTetDUgRM60BKz/gfaTvl1uU9fIlghYdrD
         kOnBOMvocOUGH3iravh2gqapKsbrsW6hFL4WeBI3XXeobh39HLoZNGhib8aNA2CVdWC+
         x7bhm9zjIUn8+LrAUS8vetHqxxYA0IDl/6lrH12IIun9Cb7LQP3aC5rMc4FZod/c/efz
         iILRrZMUgTsjmSPffKFedQ01Q8xEvfS4a94gCNUbDtA8Wfwr78WWQ1BIIFdloqIOSRKV
         mnGi8wJSLs9HNr32pINpCZAxPf5bDs+oj46Io+JG506Ywylj/TOoyCpezQkCYOWtgmWh
         FBxg==
X-Received: by 10.31.13.205 with SMTP id 196mr15359382vkn.37.1449846791645;
 Fri, 11 Dec 2015 07:13:11 -0800 (PST)
Received: by 10.31.56.209 with HTTP; Fri, 11 Dec 2015 07:13:11 -0800 (PST)
In-Reply-To: <vpq7fkl3v66.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282260>

2015-12-11 15:40 GMT+01:00 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> This is the second version of this patch.
>> Added the corrections suggested by Matthieu Moy ($gmane/282221)
>
> Sorry, but my main concern was that the patch could not be reviewed in
> good conditions as-is, and I think it still cannot be. It's very hard to
> spot which .PHONY rules you're adding and which are just code movement.
> You should really split this into one "code movement" patch and one
> "actual bugfix" patch. Or someone with better eyes than me should review
> the patch ;-).

Ok. No problem. I thought there was no need for a patch so simple. But ok.

Thank you. I will reroll.
>
>> @@ -2215,6 +2221,7 @@ test-svn-fe$X: vcs-svn/lib.a
>>  test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
>>       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
>>
>> +.PHONY: check_sha1 $(SP_OBJ) sparse check check-sha1
>>  check-sha1:: test-sha1$X
>>       ./test-sha1.sh
>>
>> @@ -2224,7 +2231,6 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>>       $(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
>>               $(SPARSE_FLAGS) $<
>>
>> -.PHONY: sparse $(SP_OBJ)
>>  sparse: $(SP_OBJ)
>
> This "sparse" movement looks again contradictory with the goal announced
> in the commit message.
The idea was to group all the phony before all the target, not to put
the phony necessarily before the closest target. but ok
>
>> @@ -2237,6 +2243,7 @@ check: common-cmds.h
>>               exit 1; \
>>       fi
>>
>> +
My bad :=)
>>  ### Installation rules
>
> Useless hunk.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
