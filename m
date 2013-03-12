From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Tue, 12 Mar 2013 01:29:45 +0100
Message-ID: <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com> <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de> <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com> <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de> <CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com> <ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de> <CADgNja=oyAVVNTAY-OG5
 U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 01:30:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFD7C-00051b-20
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 01:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab3CLAaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 20:30:20 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:50347 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754446Ab3CLAaS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 20:30:18 -0400
Received: from mailgw82.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Tue, 12 Mar 2013 01:29:56 +0100
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
	by mailgw82.hrz.uni-giessen.de (Postfix) with ESMTP id 7BE12480008C;
	Tue, 12 Mar 2013 01:29:46 +0100 (CET)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP; Tue, 12 Mar 2013 01:29:46 +0100
In-Reply-To: <CADgNja=oyAVVNTAY-OG5U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217926>


On 11.03.2013, at 23:54, Andrew Wong wrote:

> On 3/11/13, Max Horn <max@quendi.de> wrote:
>> Looking at the git config man page to check what each of my config settings
>> does, I discovered "trustctime". And adding
>> 	trustctime = false
>> to .git/config made the rebase work, every single time. Huh.
>> 
>> 
>> Adding this to the fact that a clone works fine, I wonder if  something *is*
>> touching my files, but just in that directory. But what could it be? One
>> nagging suspicion is the "file versioning" feature Apple introduced as part
>> of Time Machine in OS X 10.7; it's kind of a "version control system for
>> n00bs" for arbitrary documents. It has caused me some pain in the past.
>> 
>> But I just re-checked, and problematic repos is explicitly on the Time
>> Machine exclusion list. I also used the "tmutil isexcluded FILES" to verify
>> that the problematic files are really on the TM exclusion list. Finally, I
>> moved the one of the repos subdirectory containing most of the problematic
>> files, and then run "git checkout". In other instances, this sufficed to
>> "disassociate" a file from an unwanted TM version history. But doing that
>> had no effect here, i.e. also with the freshly regenerated files, the
>> problems appear.
> 
> Would you be able to turn off Time Machine completely and do a few
> tests? If it does works, then it becomes a matter of fixing Time
> Machine...
> 

sudo launchctl unload /System/Library/LaunchDaemons/com.apple.revisiond.plist

-> this exits revisiond, and prevents launchd from respawning it. After that, the problem is gone, on several attempts. And once I reactivate revisions, the problem reoccurs.

So it seems pretty clear what the cause of this is. Now I still need to figure out why it affects that particular repository and not others. But at this point I guess it is safe to say that Apple's auto-crap-magic revisiond is the root of the problem, and git is purely a victim. So I'll stop spamming this list with this issue for now, and see if I can figure out a fix that is less invasive than turning off revisiond completely (which some application rely on, so disabling it may break them badly).

Andrew, thank you very much for your persistent guidance and help. I definitely owe you a beverage-of-your-choice ;-).

Cheers,
Max