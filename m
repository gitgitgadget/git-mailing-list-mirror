From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 3/3] submodule: extend die message on failed checkout with depth argument
Date: Tue, 12 Jan 2016 10:29:30 +0100
Message-ID: <BCA2C81C-8DB4-4695-8A44-79B51103A684@gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com> <1450653595-22676-4-git-send-email-larsxschneider@gmail.com> <CAGZ79ka9+KxqbogbN1UnNxQ_G6U_incYKLiuadTroc90VmEWpA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 10:29:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIvGo-0008Pr-3d
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 10:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbcALJ3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 04:29:35 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33827 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964908AbcALJ3c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2016 04:29:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so30341766wmb.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 01:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OP9gxR5SLqp8NCKIExpK/vD54+Xvm8tWHX9lgM/FdJk=;
        b=YccmXTXuYz975EwhLapYFEK5a/FLKnAfEllXgSY6a53wbMmRB45Q7S+Kp2h7NwEehG
         LG9WTE/tzjw/m+5NfYba75ZzxM4rLaU+SFMjJ1hkRnHW0GPxRmTHtW1G8SUOd5vxFMSY
         v/oeoi+7Mb5XWdR2jzhVmnwQA6DsROBSBxIf3RMcpmMjOcGlLbemZ4iD34UBKM80faqM
         L1TkQfUprJnFWwovrtS8qNViToPqUKGPUYOh+3VqcnbAtAyjDqPY4N5gg1KkiOQIxGcK
         B7xQvzKyJWahO2Ob9QBvjb7yC0XQsAqejHPVn6MNBjbpWNZ4LoCJBp8eNszL915LHQCC
         +Ozw==
X-Received: by 10.194.133.102 with SMTP id pb6mr7334272wjb.12.1452590971246;
        Tue, 12 Jan 2016 01:29:31 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA136.dip0.t-ipconnect.de. [80.139.161.54])
        by smtp.gmail.com with ESMTPSA id w8sm79414742wjx.21.2016.01.12.01.29.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jan 2016 01:29:30 -0800 (PST)
In-Reply-To: <CAGZ79ka9+KxqbogbN1UnNxQ_G6U_incYKLiuadTroc90VmEWpA@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283779>


On 11 Jan 2016, at 17:26, Stefan Beller <sbeller@google.com> wrote:

> On Sun, Dec 20, 2015 at 3:19 PM,  <larsxschneider@gmail.com> wrote:
> 
>> +test_expect_success 'submodule update clone shallow submodule on non-default branch' '
>> +       git clone cloned super4 &&
>> +       pwd=$(pwd) &&
>> +       (cd super4 &&
>> +        sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
>> +        mv -f .gitmodules.tmp .gitmodules &&
>> +        test_must_fail git submodule update --init --depth=3 2>submodule.out &&
> 
> Why do we choose a depth of 3 here?
I just copied this code from the test above. Let's change that to "--depth=1" to avoid confusion.
Should I reroll or can this be fixed in the merge?

> 
>> +        test_i18ngrep --count "Commit is probably not on the default branch." submodule.out
I was just reading this and wonder if we should remove "--count". My initial intention was to
make sure this error message only happens once. However, this is not checked here anyways.

>> +    )
>> '
>> 
>> test_expect_success 'submodule update --recursive drops module name before recursing' '


Thanks,
Lars
