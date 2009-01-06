From: "Johnny Lee" <johnnylee194@gmail.com>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 6 Jan 2009 16:09:16 +0800
Message-ID: <488807870901060009i2f9f8b3dnb6be4b416d3b1318@mail.gmail.com>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
	 <20090106072253.GA9920@coredump.intra.peff.net>
	 <488807870901052352w585da727r6d4a1e4ca4238cab@mail.gmail.com>
	 <20090106080300.GA10079@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:10:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK71M-0005W9-Qt
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbZAFIJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbZAFIJR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:09:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:16048 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZAFIJR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:09:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so7243502rvb.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 00:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iotRTFntlpULFSyA3W7sVmppoHXFtj7JsO8doPQF+1o=;
        b=rb5JD64IzidCtHQwZy+1WUfp8wFUILpAfOTD+l76o/fsIEDxwmL1mnaLB16FplRiC6
         SoXz93OWWbPNmDy0xDj/jD17ilW4QqfMz1HkR2i0dCQlXdIRnwb/fjPjdo5ZgjOrtt5L
         71utcD7RvZG0zD74YfGXZFaOJ8ziwXC8y6xm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TzbyquhiKQipBW5FTRppjoZPwbfAH/hQ5/7qlT6FfjyNfyI3ja5eMwk0JOc3eN5RIB
         zYV9H3kPZiNisqJ1vTPtjtDq8fqEwC6oN03ESsmbB5pVRMib77Gqb61PD0RsoQPjyEbS
         6oNY9j40F/jwB7S612a4mhPX6Fft8TpKDoReY=
Received: by 10.142.134.17 with SMTP id h17mr9061176wfd.136.1231229356158;
        Tue, 06 Jan 2009 00:09:16 -0800 (PST)
Received: by 10.143.15.1 with HTTP; Tue, 6 Jan 2009 00:09:16 -0800 (PST)
In-Reply-To: <20090106080300.GA10079@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104644>

Ooops, forgot to cc to the mailing list.

Thanks for your sharing Peff, I'm going to check these stuffs out and
get back with any findings.

Regards,
Johnny

On Tue, Jan 6, 2009 at 4:03 PM, Jeff King <peff@peff.net> wrote:
> [re-adding git@vger; please keep discussion on-list so everyone can
> benefit from the result]
>
> On Tue, Jan 06, 2009 at 03:52:12PM +0800, Johnny Lee wrote:
>
>> Thanks Peff, I've checked the permission of .git/objects/16, it's
>> created by another user and thus I have no permission to remove it.
>>
>> In fact, this is coming from a previous bad practice on setting up a
>> collaboration repository on a SSH server, here is what I've done so
>> far:
>> [...]
>> 7. Then the user "git" has changed mode for all the files under .git
>> to writable.
>>
>> 8. This time, user "johnny" can push successfully.
>
> If you are going to have multiple users sharing a repository, generally
> they should be in the same group and the core.sharedrepository config
> option should be set (see "git help config", or the "shared" option to
> git-init).
>
> I've never used that personally, though. I have always just used POSIX
> ACLs, with a default ACL on each directory giving access to everyone.
> E.g. (off the top of my head):
>
>  for user in user1 user2 user3; do
>    setfacl -R -m u:$user:rwX -m d:u:$user:rwX /path/to/repo
>  done
>
> -Peff
>



-- 
we all have our crosses to bear
