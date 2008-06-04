From: "Sean Brown" <seanmichaelbrown@gmail.com>
Subject: Re: move git repository out of a folder?
Date: Wed, 4 Jun 2008 16:18:29 -0400
Message-ID: <1086fb5f0806041318u3b1c4a3cg4dbc73fb638ea16b@mail.gmail.com>
References: <1086fb5f0806041303v7856404dxb95b5a450ac30ae1@mail.gmail.com>
	 <20080604200724.GV12896@spearce.org>
	 <m31w3dyn2n.fsf@localhost.localdomain>
Reply-To: seanmichaelbrown@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zYb-0002Fl-2z
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbYFDUZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbYFDUZH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:25:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:49602 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbYFDUZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:25:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so143237fgg.17
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 13:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9zGTn1ZwZAmyHHnmYyW8xpieHuWs5UJhRRbWUiXqRPg=;
        b=BwNzNQl585OZp7bSHuIVDE0LBWVuiWlapkTK854ZfMyuOVKxBuqv07eZEQvppCja09
         3ZbMaom/fEv7Cuas56WGxFSUDCKP8UnZ/rvXKPhlUHAda/LWVtSB8nSQf8ZXHr74+H7g
         QEO5DVQKIc6Z+SM/xmfCiyDuvziirvngPy+p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Cq9fLy+F2SyvTPdCHvLCi/hk9EUU+KjHU4c+1inGZE7TaE2/dwnLDz1zwf7OiFb/Rd
         hzoS5XFWnPev5jrW9bwKqBOD5qDosdbd+Q7MaN4xpi1OCzAvr4P0UNR0MV9J4dFQXwSe
         CcSGvxWcKwzqpf8YtKKijsP8M8+Ii/p2IAE1U=
Received: by 10.86.82.16 with SMTP id f16mr791255fgb.9.1212610709248;
        Wed, 04 Jun 2008 13:18:29 -0700 (PDT)
Received: by 10.86.53.12 with HTTP; Wed, 4 Jun 2008 13:18:29 -0700 (PDT)
In-Reply-To: <m31w3dyn2n.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83825>

On Wed, Jun 4, 2008 at 4:14 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Sean Brown <seanmichaelbrown@gmail.com> wrote:
>> >
>> > Let's say I've got this directory structure of source files:
>> >
>> > /folderA
>> > /folderA/sourcecode/
>> > /folderA/sourcecode/file1.txt
>> > /folderA/sourcecode/file2.txt
>> > etc...
>> >
>> > When putting the project under git source control, I did this:
>> >
>> > cd /folderA
>> > git init
>> >
>> > So now when colleagues clone my repository, they get the source code
>> > in the "sourcecode" folder.  I'd like to just make the repository
>> > simply give them the source files, not in a directory.  In other
>> > words, as if I had originally been smart and done this:
>> >
>> > cd /folderA/sourcecode
>> > git init
>> >
>> > Can I make that happen without losing all of the history?
>>
>> git mv sourcecode/* .
>> rmdir sourcecode
>> git commit
>
> What he said.  Git should automatically detect renames.  When pulling
> code from someone who hasn't made this change yet, you might need to
> use 'subtree' merge strategy, as currently git would put files added
> as sourcecode/filename in sourcecode/filename, not as top dir filename
> when pulling from side branch.
>
> If you want to _change history_, as if you made correct decision at
> the start (and convince everyone to reclone, or to do the same
> surgery; or if you for the time being are solo contributor to the
> project), you can use git-filter-branch (formerly cg-admin-rewrite-hist ;-).
>

Thank you Shawn and Jakub.  This worked perfectly.

Sean
