From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 23:46:18 +0100
Organization: OPDS
Message-ID: <62FDB1B489D749349DDEE076E689C32E@PhilipOakley>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com><xmqqd2opu8hr.fsf@gitster.dls.corp.google.com><CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com><xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com><20130904081047.GB2582@serenity.lan><xmqqa9jso69u.fsf@gitster.dls.corp.google.com><7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley><xmqqr4d4jird.fsf@gitster.dls.corp.google.com><CAMP44s0kMbXvcJbWvJDu=8A5iOeH4fsMGUdT-ehXKNXiV1FQ1Q@mail.gmail.com><522C168B.7050300@bbn.com> <xmqqa9jn6v6q.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"John Keeping" <john@keeping.me.uk>, <git@vger.kernel.org>,
	"Andreas Krey" <a.krey@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Richard Hansen" <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 00:45:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VInjt-00023V-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 00:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177Ab3IHWpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 18:45:49 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:54678 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750847Ab3IHWpt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 18:45:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AscLAAv9LFJOl3GZ/2dsb2JhbABagweJcbkfBAQBgSMXdIIgBQEBBAEIAQEuHgEBIQUGAgMFAgEDFQECCSUUAQQaBgcXBgESCAIBAgMBh2sKxXOQAIMkgQADiH2GEppMgyE7
X-IPAS-Result: AscLAAv9LFJOl3GZ/2dsb2JhbABagweJcbkfBAQBgSMXdIIgBQEBBAEIAQEuHgEBIQUGAgMFAgEDFQECCSUUAQQaBgcXBgESCAIBAgMBh2sKxXOQAIMkgQADiH2GEppMgyE7
X-IronPort-AV: E=Sophos;i="4.90,866,1371078000"; 
   d="scan'208";a="431210094"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip05ir2.opaltelecom.net with SMTP; 08 Sep 2013 23:45:46 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234273>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, September 08, 2013 7:10 PM
> Richard Hansen <rhansen@bbn.com> writes:
>
>> On 2013-09-07 22:41, Felipe Contreras wrote:
>>> On Wed, Sep 4, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> 
>>> wrote:
>>>
>>>> Which can be solved by adding the above "fail" option, and then
>>>> renaming them to "pull.integrate" and "branch.<name>.integrate" to
>>>> clarify what these variables are about (it is no longer "do you
>>>> rebase or not---if you choose not to rebase, by definition you are
>>>> going to merge", as there is a third choice to "fail"), while
>>>> retaining "pull.rebase" and "branch.<name>.rebase" as a deprecated
>>>> synonym.
>>>
>>> All these names are completely unintuitive. First of all, why
>>> "integrate"? Integrate what to what? And then, why "fail"? Fail on
>>> what circumstances? Always?
>>>
>>> My proposal that does:
>>>
>>>   pull.mode = merge/rebase/merge-ff-only
>>>
>>> Is way more intuitive.
>>
>> +1
>>
>> What about something like:
>>
>>     pull.mergeoptions (defaults to --ff-only)
>>     pull.rebaseoptions (defaults to empty?  --preserve-merges?)
>>     branch.<name>.pull.mergeoptions (defaults to pull.mergeoptions)
>>     branch.<name>.pull.rebaseoptions (defaults to pull.rebaseoptions)
>
> As "pull" has two distinct phases "fetch" and "merge/rebase", your
> mergeoptions/rebaseoptions is much better than "mode", which does
> not tell which phase of "pull" the mode refers to. It is clear that
> they apply to the process to integrate the history obtained from
> the other side and your own history into one history.
>
> But it does not help Philip's case, if I understand correctly, where
> running "git pull" on some branches is always a mistake

Not quite always, it's when it won't fast forward

>                                     and the user
> wants it to stop at "fetch the history and objects needed to
> complete the history from the other side" phase without proceeding
> to the "then integrate the history from the other side and the
> history of your branch into one" step,

Yes, it/Git should stop and wait for instructions...

>                   which may be done with either
> merge or rebase.

Here I would typically rebase onto an adjusted destination, e.g. onto 
pu, or maybe next, rather than master (or vice versa depending on 
expectations). That is its a feature branch that needs to decide what 
it's on top of (well, I need to decide ;-)

>            Even if we ignore that "always fail, do not do
> anything" use case, your two seemingly independent "mergeoptions"
> and "rebaseoptions" do not tell us which one is preferred between
> merge and rebase.  A single
>
>    pull.<someoption> = rebase | merge [| always-fail]
>
> makes that choice in a clear way, I think.

or 'fail on non-ff' (which may or may not be the users, or Git's 
default, as per the series title ;-)

>
> Regarding the verb "integrate".
>
> We used to explain "pull" is a "fetch" followed by a "merge".  With
> more people using "git pull --rebase", the word "merge" used in that
> explanation of "pull" stopped being generic enough.  Simplarily the
> "upstream branch" of local branch X is "what you fetch and merge to
> update the branch X" but that 'merge' can be 'rebase'.  We needed a
> verb to call the process of integrate the two histories into one.
>
> "git pull --help" since 153d7265 (pull: change the description to
> "integrate" changes, 2013-07-07) uses that verb [*1*].
>
> And that is where the name of the single configuration to pick how
> to integrate the history obtained by the first phase of "pull" came
> from.
>
>
> [Footnote]
>
> *1* I suspect that there may still be places in the documentation
> that have not been updated since the days back when the only valid
> way to integrate two lines of histories was to merge, and updating
> them may be a low-hanging fruit. Hint, hint.
>
>
--
Philip
