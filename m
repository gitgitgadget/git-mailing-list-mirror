From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Directory renames without breaking git log.
Date: Thu, 4 Sep 2008 11:35:45 -0700
Message-ID: <905315640809041135m4026cf90h7f506bb3d295b09a@mail.gmail.com>
References: <200809032338.35359.kai@samba.org>
	 <905315640809031716j7d74d7a6m51b434f62b011135@mail.gmail.com>
	 <200809040853.36433.kai@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Kai Blin" <kai@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 20:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbJhS-0002EH-Ka
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 20:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbYIDSft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 14:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbYIDSfs
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 14:35:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:52709 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542AbYIDSfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 14:35:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so31495nfc.21
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=G4tFiBB92YtQBbA7GsHI3EvM8/sv95b1nOqNrGK25+w=;
        b=IuB56dNEJ33X4rdlp0JvlnSg0+NZVT3mN8ZM6GBcdtsvv+nrHO9yMdOEsXzE9UAfo1
         x/jhobiv4dQEAJeXBZGpI+54/PRCFQRCvYshs2hyitOBmv/A8K/9pr4PzMaor8aZnYLD
         PRYc7G3tT3+B1bTTJW4bGsGdCgljvl4PJMBLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=A6+rnoP1hRrwCK9nllYMnBCTu7LqmBBmmrk6EKlk/Sdsv/pSloUFkGIUns9//nMkE4
         AIwpuXI//LbWH5HYuuJUolvPNeeZtx1u8PVd8VFS9h+h0p02nOHBiVZ18C4i542mCz+v
         8H6viivQzS+UW2w9y9BlqNYtZepWYzJyfQkv0=
Received: by 10.210.45.14 with SMTP id s14mr12336025ebs.52.1220553345262;
        Thu, 04 Sep 2008 11:35:45 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Thu, 4 Sep 2008 11:35:45 -0700 (PDT)
In-Reply-To: <200809040853.36433.kai@samba.org>
Content-Disposition: inline
X-Google-Sender-Auth: 4d326f029accdb52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94944>

(you're probably better off asking on the whole list, as I don't know much)

On Wed, Sep 3, 2008 at 11:53 PM, Kai Blin <kai@samba.org> wrote:
> On Thursday 04 September 2008 02:16:24 you wrote:
>> On Wed, Sep 3, 2008 at 2:38 PM, Kai Blin <kai@samba.org> wrote:
>> > Unfortunately, the directories are big enough that git log stops to track
>> > the renamed files, so e.g. git log ./samba3 does not show the samba3
>> > history. The history is not lost, of course, but it's way less intuitive
>> > to get it.
>>
>> You can try setting diff.renamelimit to 0 in your ~/.gitconfig.  See
>> Linus's email here for a similar situation in the kernel:
>> http://lwn.net/Articles/292948/
>
> That doesn't seem to fix "git log path/to/file" cases. The really interesting
> part is that if I try git log --follow -M -C path/to/file, I don't get any
> history at all. (--follow is the culprit, if I remove that I at least get the
> merge commit)

OK, I actually tried with your example, and see what you mean.  It
looks like follow does not work with this case.  See
http://permalink.gmane.org/gmane.comp.version-control.git/85766
for an illustration of --follow not working with the subtree merge
strategy, which as far as I can tell is pretty much the same as this
case.  Also it sounds like follow only works with single files, and
not directories:
http://kerneltrap.org/mailarchive/git/2008/5/4/1714694

Why these do not work is way beyond my git knowledge.  As far as I
know (which is very little), follow could work for these cases, but it
currently does not.

> git blame still works, and git log --sparse path/to/file works, of
> course. --sparse makes giving a path a bit pointless, of course, but we
> probably can live with that for time being. I'm still open for suggestions,
> of course. :)

Glad that git blame works.  If you haven't already, you should also
try git gui blame too for better interactivity.

Thanks,
Tarmigan
