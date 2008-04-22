From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Wed, 23 Apr 2008 01:20:18 +0800
Message-ID: <46dff0320804221020o40684b78i7140af9f56f27756@mail.gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
	 <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
	 <7v3ape2ufs.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804220209n590a0684x876270c7b1c0c2d@mail.gmail.com>
	 <46dff0320804220738u760a05f7q4ec9cbf144d78480@mail.gmail.com>
	 <46dff0320804220741p4d3f3080w493fb96dc4983a1c@mail.gmail.com>
	 <alpine.DEB.1.00.0804221609200.4460@eeepc-johanness>
	 <46dff0320804220954y171df9b6t199f4864a32d4195@mail.gmail.com>
	 <m37ieprexc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:21:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoMB1-0007k5-Uc
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbYDVRUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755596AbYDVRUU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:20:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:61882 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbYDVRUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:20:19 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1298474wra.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oRWYZQ8ydTOg9wdR6KY4XojlCyjNK5T68kCnp2i/pTk=;
        b=VJZ0OrGXcwHNYfq89NgkfQGt1isH/4dz+MOQXTCEgReV+zVAEw0Tyg7GtD8b+ANBVSD148Ae6ggxeJnjtkgnrqmo5hmZmWHjv6e8Z8FyK0Coe5vwtBj7t6tnIoRooCmOJalYXnGbSIRBUgeqcAo6zIPdDIS7EPxfEHzgmyqUV40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PpVNC0ZyiEJZyc5r6n53dmg+WFhdGOq+OysgFtFc2iZb244Hy+6wLSS3mkyHoKhV1IoyxJFbTtq1wotRIg8CgfrOOWJCN9GcRZzIUzGHfgxIZ/TGr2wUIFveUzWvTDZPnMVL5CGXKdJjhJOd8j/wxpVeP3Sk2p4g4gJ8qQxLZfg=
Received: by 10.100.136.15 with SMTP id j15mr791461and.59.1208884818187;
        Tue, 22 Apr 2008 10:20:18 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 10:20:18 -0700 (PDT)
In-Reply-To: <m37ieprexc.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80146>

On Wed, Apr 23, 2008 at 1:13 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>  > On Tue, Apr 22, 2008 at 11:10 PM, Johannes Schindelin
>  > <Johannes.Schindelin@gmx.de> wrote:
>
> >>  On Tue, 22 Apr 2008, Ping Yin wrote:
>  [...]
>
> >>> Only the commit message changes.
>  >>>
>  >>> [... only the commit message ...]
>  >>
>  >>  Do you realize how much work you make Junio do?  It would be definitely
>  >>  better if you tried to relieve him of as much burden as you can.
>  >
>  > I'm sorry about that. It's just because that i don't have a mail
>  > client at hand. I use gmail which will wrap lines. And if i use
>  > git-sendmail, i can't send this message as a reply to previous
>  > messages.
>
>  Errr, '--in-reply-to' option to git-send-email?
>
3x, i think this makes sense.


-- 
Ping Yin
