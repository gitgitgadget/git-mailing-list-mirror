From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 6/6] Add Travis CI support
Date: Fri, 20 Nov 2015 10:29:47 +0100
Message-ID: <4304B1FC-B80A-459E-B4EA-CBDABB82A796@gmail.com>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com> <1447923491-15330-7-git-send-email-larsxschneider@gmail.com> <20151119143528.GC9353@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 10:30:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzi1h-0006To-5H
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 10:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759535AbbKTJad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 04:30:33 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37849 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161526AbbKTJ3v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 04:29:51 -0500
Received: by wmww144 with SMTP id w144so13076409wmw.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 01:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pMf6nIhXQU0AEtvEvevlvLqfZGPosBLcsFUhNcmxbEU=;
        b=0vRKcIkYR77BFWZCJM/wlFAROvmYQxcKVshzzX9COY9jxWhDFDBg1dkZuDaJSl/kuM
         mF1T684Hrer8EBXRsOZiB9dmO+i3Ce4tlOEwGkpIT57T/F3mak8Vo9k2FxO0SewZ1Xyi
         ycgm7orN+80dn5zKS/zSbGWw6O00nFa9/w0TxD25E60z4s1W9vhj3vVkCCBjjTWPRA02
         hSxy+VbVKlsF/yDXEQ5VFYDn4658o/KgfiVuXcqcNHjePD1hbb+CzqB7PBU3gZfUEV34
         tB44TVJo3wAK3ddUtDhHG23bUR9KsIE9d26IKtMUkP5NnGANYq0ceYy+b+bdNdPCB/Vy
         VcUw==
X-Received: by 10.28.45.216 with SMTP id t207mr1206381wmt.89.1448011789684;
        Fri, 20 Nov 2015 01:29:49 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB7A5B.dip0.t-ipconnect.de. [93.219.122.91])
        by smtp.gmail.com with ESMTPSA id q1sm11746850wjy.31.2015.11.20.01.29.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Nov 2015 01:29:48 -0800 (PST)
In-Reply-To: <20151119143528.GC9353@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281500>


On 19 Nov 2015, at 15:35, Jeff King <peff@peff.net> wrote:

> On Thu, Nov 19, 2015 at 09:58:11AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
>> 64 bit" and on "OS X Mavericks" using gcc and clang.
>> 
>> Perforce and Git-LFS are installed and therefore available for the
>> respective tests.
> 
> My overall impression is that this is a lot more complicated than I was
> expecting. Can we start with something simpler to gain experience with
> Travis?  And then we can add in more complexity later.
> 
> For example:
> 
>> +addons:
>> +  apt:
>> +    packages:
>> +    - language-pack-is
> 
> I doubt most people are running the t0204 right now. Maybe we should
> start without it.

Well, I think the entire point of a CI is to run automatically tests that most people are *not* running. Plus I can't recall any problems with language-pack-is and t0204.

> 
>> +env:
>> +  global:
>> +    - P4_VERSION="15.1"
>> +    - GIT_LFS_VERSION="1.0.2"
> 
> I know p4 is your area of interest, but from a project perspective, it
> seems like an odd choice for the initial set of tests.

See above. Most people do not execute the p4 tests because they don't have p4 installed. Therefore these tests have the highest risk to brake unnoticed.

> 
>> +    - DEFAULT_TEST_TARGET=prove
>> +    - GIT_PROVE_OPTS="--timer --jobs 3"
>> +    - GIT_TEST_OPTS="--verbose --tee"
> 
> These all make sense, I guess.
> 
>> +    - GETTEXT_ISO_LOCALE=YesPlease
>> +    - GETTEXT_LOCALE=YesPlease
> 
> What are these? I don't think we have any such Makefile knobs. These
> look like variables that get used internally by the test suite, but we
> shouldn't need to set them.

These are used in t020*. I enabled them to run the tests and I haven't seen any problems. However, I am no expert in that area. I'll remove them.

> 
>> +    # - GETTEXT_POISON=YesPlease
> 
> I'm assuming the "#" means this is commented out. Can we just drop such
> cruft?

Yes, for the final submission of course. I just wanted to make it stick out as I wasn't able to run the tests successfully with this flag. I wonder if someone can explain to me how it works.

> 
>> +    - GIT_TEST_CHAIN_LINT=YesPlease
> 
> This is the default, and we don't need to specify it.

OK

> 
>> +    - GIT_TEST_CLONE_2GB=YesPlease
> 
> Is it a good idea to run such an expensive test?

Well, it's a CI machine that does not block anyone. I doubt that people run these tests on their local machines for exactly the reason you just described. Therefore I would rather run these tests.

> 
>> +  matrix:
>> +    -
>> +      # NO_ICONV=YesPlease
> 
> Ditto here on the commenting.

OK. Setting NO_ICONV brakes a lot of tests. Do we really "support" that flag?

> 
>> +    - >
>> +      NO_CURL=YesPlease
> 
> So if I understand correctly, the point of this list is to test
> alternate configurations. So compiling without curl makes some sense, I
> guess. Though mostly it will just shut off a bunch off tests.
> 
>> +      NO_D_INO_IN_DIRENT=YesPlease
> 
> But setting platform compat knobs like this seems weird. Nobody sets
> this manually. Either your platform has it, or it does not. And we are
> already testing on alternate platforms to cover such things.
> 
> If there's a specific config setup of interest, it makes sense to me to
> try to increase test coverage there. But it feels like you've just
> picked a random laundry list of Makefile knobs and tweaked them, without
> any sense of whether they even make sense together, or match the
> platform.
> 
> For instance:
> 
>> +      NO_STRCASESTR=YesPlease
>> +      NO_STRLCPY=YesPlease
> 
> I wouldn't not be surprised if these cause problems building on some
> platforms that _do_ have these functions.

Agreed. As mentioned in gmane/280963 [1] I am no expert in these flags.  Should I remove the "NO_*" test configuration all together?

[1] http://article.gmane.org/gmane.comp.version-control.git/280963/match=no_

> 
>> +    echo "$(tput setaf 6)Perfoce Server Version$(tput sgr0)";
>> +    p4d -V | grep Rev.;
>> +    echo "$(tput setaf 6)Perfoce Client Version$(tput sgr0)";
>> +    p4 -V | grep Rev.;
> 
> s/Perfoce/Perforce/ :)

Thanks :)


>> +before_script: make configure && ./configure && make --jobs=2
> 
> Hmm. I wonder if we actually want to use autoconf here at all; most devs
> do not use it, and Git should generally compile out of the box based on
> config.mak.uname (and if it doesn't, it would be nice to know).
> 
> There may be some optional packages that autoconf helps with, though.

Compiling without autoconf works for Linux but not for OS X:
https://travis-ci.org/larsxschneider/git/jobs/92222770


> So overall, I dunno. I do not want to create a bunch of work for you in
> splitting it up. But I'm hesitant to merge something that has a bunch of
> lines that I'm not sure I understand the reasoning for. :-/

I understand. How about this: I create a new roll where I...
... remove the "NO_*" configuration for now.
... remove GETTEXT_* flags
... disable flaky t9810 and t9816 in the Travis CI run
... disable autoconf and try to fix the OS X issue

> 
> I was hoping the first cut could just be telling Travis to run "make
> test", without much fanfare beyond that. Maybe that's not realistic.


Thanks,
Lars
