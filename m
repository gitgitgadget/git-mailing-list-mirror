From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 12/13] Documentation/Makefile: update git guide links
Date: Tue, 26 Feb 2013 20:24:45 +0000
Message-ID: <512D1A0D.7020203@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org> <1361660761-1932-13-git-send-email-philipoakley@iee.org> <7vd2vp3qru.fsf@alter.siamese.dyndns.org> <512BF71E.3080304@iee.org> <7va9qsndnn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAR5O-000812-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334Ab3BZUYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:24:49 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:29249 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753015Ab3BZUYs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2013 15:24:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAEoZLVFZ8rke/2dsb2JhbAANOMF1gRWDEgEBAQECAThAAQULCxgJFg8JAwIBAgFFBg0BBQIBAYgJrGKDMZAQjxQHg0ADqjA
X-IronPort-AV: E=Sophos;i="4.84,742,1355097600"; 
   d="scan'208";a="63914997"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 26 Feb 2013 20:24:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7va9qsndnn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217177>

On 26/02/13 00:04, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> On 25/02/13 05:29, Junio C Hamano wrote:
>> ...
>>> In other words, can't you change the side that launches the document
>>> viewer so that we do not have to rename anything in the first place?
>>
>> The current help code will only show either 'git-<cmd>' man pages, or
>> git<guide>' pages so the current everyday and user-manual pages aren't
>> served by the existing help code.
>
> That is exactly what I meant by "the side that launches the document
> viewer".  We obviously would not want to type
>
> 	$ git help gituser-manual
>          $ git help giteveryday
Neither do I...

>
> I was wondering if you can keep document names as-is, register these
> names without "git" prefix (i.e. "user-manual.html")

I don't register them at all. I'm simply gathering a list of common 
guides in the array so that I can show that list as a 'usage' list, in 
exactly the same manner as the common commands list is used when 'git 
help' [ no options] is typed.

>   to the list of
> guide documents you are generating and compiling into the binary,
> and let the user ask:
>
> 	$ git help everyday

This is the existing way.
'git help tutorial' will display the gittutorial.txt man page - Note the 
git prefix is required by the code.

It is interesting to note that 'git help k' and 'git help gitk' produce 
the same response, while gitk can't be a common-command because it 
doesn't have a dashed form so isn't picked up by the script ;-)

>
> which you would turn into "browser %s/%s.html" % (GIT_HTML_PATH, 'everyday'),
> after checking "everyday" is one of the guides that are available to us.
>
> If some guides are already named with git prefix, you can keep them
> in the compiled-in list with that name.  We do not have to worry
> about redirects and people's bookmarks if we can avoid renaming
> existing pages, so "because grabbing everything with git* glob was
> easier to write the generate-guidelist script" is a false economy.

I was hoping to avoid more special casing of special files for special 
purposes..
> That is the single place we can afford to spend extra effort to make
> the end result easier to use by the users, no?
It could be done.

>
> Or am I misreading the series completely?
Yes, I think so (in terms of my starting point and approach).

I was using the existing common-commands approach _just_ to display a 
'usage' string of common guides. so that new users would be informed of 
their presence, and then they would use the existing command 'git help 
<guide>' to read about it (see also patch 2/13).

It was just unfortunate that the user-manual and everyday didn't fit the 
existing naming pattern causing the writing of patch 8 & 9 et seq to 
sort the renames to fit the pattern (just like git-remote-helpers)

Also, I think it's the user-manual, one of the files doesn't fit the 
'man page' style required by the MAN7 list in Documentation/Makefile, so 
that's another potential complication I need to bottom out - most likely 
keep it 'as is' in the Makefile and check that the Help command will 
display it properly if done that way.

Philip
