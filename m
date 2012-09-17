From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Mon, 17 Sep 2012 23:55:58 +0100
Organization: OPDS
Message-ID: <98180D4AA94C468887029389CC535D4F@PhilipOakley>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com> <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley> <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:56:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDkEQ-00088Z-60
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 00:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab2IQWzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 18:55:49 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:43991 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754670Ab2IQWzt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 18:55:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuQKAPWSV1BZ8rU+/2dsb2JhbAArGoYHhT+vWQJ/gQiCGwUBAQQBCAEBFwEFER4BARwFCwIDBQIBAxUEAwUGGgMCFAEEGgYHFwYTCAIBAgMBh2kKByynHwGSbQSBHoocAYFOg2s1YAONZZgegmeBYg
X-IronPort-AV: E=Sophos;i="4.80,438,1344207600"; 
   d="scan'208";a="403620426"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip02ir2.opaltelecom.net with SMTP; 17 Sep 2012 23:55:47 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205766>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> "Typically it will be placed in a MUA’s drafts folder, edited to add
>> timely commentary that should not go in the changelog after the three
>> dashes, and then sent as a message whose body, in our example, starts
>> with "arch/arm config files were…". On the receiving end, readers 
>> can
>> save interesting patches in a UNIX mailbox and apply them with
>> git-am(1)."
>>
>> hides a multitude of implicit knowledge steps. Is there an extended
>> description of what that would mean from a platform independent
>> viewpoint? e.g. if the patches are separte files and an mbox is one
>> consolidated file, how to get from one to the other so that 'it' can 
>> be
>> sent by 'git send-mail'.
>
> If you plan to use "git send-email" to send the final results out,
> you should consider "git send-email" as your "MUA" in the quoted
> paragraph.  And that will be very platform independent viewpoint to
> see things from.

On git for windows (msysgit)n there were a couple of other steps I had 
to do https://git.wiki.kernel.org/index.php/MSysGit:UsingSendEmail as 
Outlooklook Express isn't really a suitable MUA ;-)  [noted for other 
list readers]

>
> "git format-patch -o my-series/ --cover-letter ..."  would treat
> "my-series/" directory as "MUA's drafts folder" and prepares the
> messages you would want to send out, and you can proof-read and edit
> the files in there before telling your "MUA" to send them out, with
> "git send-email ... my-series/*.patch" or something.
>

I hadn't picked up from the man page that the --cover-letter would do 
the [PATCH 0/n] - should it?

>> I'm also missing an understanding of the preparation stage where one
>> tries to tidy up the various commit messages becaue they weren't
>> explicit, specfic nor concise enough,...
>
> Many people usually do "rebase -i" until perfection and then a
> single final invocation of "format-patch".  Of course, the "final"
> can and should further be proof-read and it is fine to do typofixes
> in the format-patch output files without going back to the commits
> before sending them out.

I did an initial rebase to correct a few obvious mistakes (e.g. an extra 
file that had crept in), but then, after some false starts, used
    git format-patch pu --stdout > fix_Docs.patch
to get a single file I could inspect and refine for both the commit 
messages and content.

I then applied it (using git am) to a temp branch to see what it 
produced, and could repeat the cycle until the patches looked right.
>
>> ...so I suspect that there is an
>> implicit `git format-patch` <-> `git am` loop of sharpening the mbox
>> patches before submission to the list that I'm missing. Has this
>> described somewhere?
> --

However, when it came to creating the series, with comments, I couldn't 
see a way of having my comments within my local commits, but preparing a 
patch series that would properly include the '---' separator.

Is there a way of getting format-patch to change some line break 
sequence (within the commit message) to the '---' three dashes patch 
break suitable for submission to the list?

Philip
