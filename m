From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: gitweb: using quotemeta
Date: Mon, 2 Oct 2006 13:12:56 -0700 (PDT)
Message-ID: <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com>
References: <efpme9$o13$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Oct 02 22:14:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUU9t-0004AN-PQ
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 22:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWJBUM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWJBUM5
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 16:12:57 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:35920 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964952AbWJBUM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 16:12:56 -0400
Received: (qmail 89411 invoked by uid 60001); 2 Oct 2006 20:12:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hBU9/mV+LO/zs4+XSRdwkzHXRKYz9kwpicbYIS8G2E6GIjQrV3Gedt+AdAwcGC4DxeIDOV7mg04YHrvWGY8suAX88F3pWoZslT1/CrC1GL9/lxbGjoT86Vdx0gONav1OqH03UiganeRkhZZLyj6eVwDGRY1PRDqL7lGnsuV3cC4=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Mon, 02 Oct 2006 13:12:56 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <efpme9$o13$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28236>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> 
> > --- Junio C Hamano <junkio@cox.net> wrote:
> >> 
> >> Ouch, that was a sloppy planning and coding, and sloppier
> >> reviewing.  Sorry.
> >> 
> >> What is the right quoting there?  Just quoting double-quotes?
> > 
> > I'm not sure.  What undesired character could we have in $filename
> > of a snapshot?  The commit ab41dfbfd4f message gives this
> > justification: "Just in case filename contains end of line character."
> > 
> > It looks like $filename is constructed by well defined strings:
> > basename($project), $hash and $suffix all of which should be ok.
> > 
> > I'd say we don't need quotemeta for $filename of snapshot.
> 
> But we do need quoting for blob_plain and perhaps blobdiff_plain
> views, although not quotemeta, but perhaps the reverse of unescape,
> i.e. quote '"', EOLN (end of line) and perhaps also TAB.

Escaping for the purposes of HTML _view_ and URL generation is ok,
but it is not ok when _saving_ the file with a file name.

A file name is just a string of chars, and I want to _save_ the file
name as its name is. No changes or interpretations please.  I don't
care what the string is, what chars it is made of, etc.

Please don't interpret file names and their characters when the files
are _saved_ by the user's browser.

The file name in my filesystem should be the exact same file name
as it appears on any other filesystem hosting the same git repo.

I don't want this translation:
Server FS: linux-2.6.git-5c2d97cb31fb77981797fec46230ca005b865799.tar.gz
Quotemeta: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz
User FS: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz

When you comitted ab41dfbfd4f3f9fedac71550027e9813b11abe3d, it extended
quotemeta to where it shouldn't have been applied.

    Luben
P.S. When replying please don't redact the CC field.
