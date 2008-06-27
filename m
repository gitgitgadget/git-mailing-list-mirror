From: "Dana How" <danahow@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Fri, 27 Jun 2008 11:09:56 -0700
Message-ID: <56b7f5510806271109p58b4ce47ucdcd382faa463015@mail.gmail.com>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
	 <20080626112233.GA17625@cuci.nl>
	 <32541b130806271001t35eb97d2gb841e194b54f214@mail.gmail.com>
	 <m3lk0qiy2i.fsf@localhost.localdomain>
	 <32541b130806271056k4698a607r11e9fbaf9102e6f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:11:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCIPT-000333-TZ
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758479AbYF0SJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758467AbYF0SJ7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:09:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:17886 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbYF0SJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:09:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so291375fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NKfA+ClGtXNigP3YVt29/wuVzKXdqgqh6iHYGzdzxO4=;
        b=Rj8D3yvIX0OkJ1w8y90EdIERFoyu4KcfVI7bbRr6Y7MC0NoJnWsJOKkbWX7HEV25AE
         Hq2FgUyghL3qtFrbio68Rt7Z8r9bgP7NOyMvwRXV4aFSWH9aV3VxmNIrup4ExmL//73K
         +zO0FYX2PCzfQ14gjN4YfMwTUCaRUr//a26Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AOBTOKV5BQK+xQjtN1c2egYsY7CZjO4a/ZBJGDCacAHVxza1HsVCoAtOKe8Qm2TLdw
         P47yw8TstzrUeAHlVb1lnzUsmRJfCRKjBekiCan/nY4EBqgvN8kFCicQMEfCOwagUbG9
         liUhWwgBFG5DMinGc71wmM2SVMYNoqHc6bR+I=
Received: by 10.78.168.6 with SMTP id q6mr546124hue.42.1214590196325;
        Fri, 27 Jun 2008 11:09:56 -0700 (PDT)
Received: by 10.78.130.7 with HTTP; Fri, 27 Jun 2008 11:09:56 -0700 (PDT)
In-Reply-To: <32541b130806271056k4698a607r11e9fbaf9102e6f1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86616>

On Fri, Jun 27, 2008 at 10:56 AM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 6/27/08, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Avery Pennarun" <apenwarr@gmail.com> writes:
>> > On 6/26/08, Stephen R. van den Berg <srb@cuci.nl> wrote:
>>  >> Avery Pennarun wrote:
>>  >>> 1) What's a sensible way to tell git to *not* opendir() specific
>>  >>> directories to look for unexpected files in "git status"?  (I don't
>>  >>> think I know enough to implement this myself.)
>>  >>
>>  >> Would checking the mtime on the directory itself help?
>>  >
>>  > I'm guessing it would help somewhat (although not as much as not
>>  > checking anything at all).  However, we'd still have to check the
>>  > mtime *against* something, and I don't think the index stores
>>  > information about directories themselves.
>>
>> By the way, from time to time there on this mailing list is idea
>>  to add entries for directories in the index.  This could help situation
>>  like yours, tracking emty directories, faster operations when some trees
>>  are unchanged, subtree <-> subproject changes.
>>
>>  But it always comes back to: 1.) no proposed implementation, 2.) "git
>>  tracks contents"...
>
> Yes, I've seen the occasional discussions about this.
>
> I might volunteer to help solve (1) except that I have a feeling that
> changing the index format would mangle all sorts of things beyond my
> current understanding.  Attaining that understanding might not be so
> bad, except for (2), which seems like any proposed changes will
> probably be rejected anyhow.
>
> So naturally I was hoping for a magical alternative suggestion for my
> current problem instead :)  One option I'm thinking about is to have
> my proposed daemon keep its own "index", which tracks *all* the files
> on the filesystem, not just the ones that have been
> git-update-index'd.  Then anything that needs to compare against the
> filesystem can choose to compare against the contents of this file
> instead if it exists (and/or the right option is set, etc).  Does that
> sound sane?
It sounds sane to me b/c I had the same reaction to this discussion.
You mean "all the files in the _worktree_" ?
You would use e.g. inotify on all the directories except .git?
This would be very helpful with an extremely large number of files.

Thanks,
-- 
Dana L. How danahow@gmail.com +1 650 804 5991 cell
