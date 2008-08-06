From: "Peter Harris" <peter@peter.is-a-geek.org>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 6 Aug 2008 08:35:25 -0400
Message-ID: <eaa105840808060535p783536b2i6f4036f6a67989a4@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
	 <200807231852.10206.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231356540.8986@racer>
	 <20080806111545.GD32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 06 14:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQiFt-0001k1-DM
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 14:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbYHFMfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 08:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbYHFMfc
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 08:35:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61167 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbYHFMf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 08:35:28 -0400
Received: by ug-out-1314.google.com with SMTP id h2so187334ugf.16
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=LCx591dOOWmTFS32UV25Axxyi8XL4lzwvNqutY7JWhM=;
        b=Bs724HPyTjgTZN33ftpCrjlfU3Q7v180vBoTLg7x+kRgEgiRIhs+AqxJSBhEIOaDxR
         Dpgs4sCOdv8o/PYd7Pfi8l9kslfKdWBqiaUxJpA6PrIErt4w9kGrGDH5dMZYaLVj5fdl
         qIDGI5FKsJQFGvjxR+yZ31lxnoRyD9cyZeVNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=V4Ayi3x+klaI6gGM86nBMnCHBP/L0JSkokbGejeeV9XfLOwW2GXnLmDYQgwEAR8tjl
         R5R0Jtnok27O/Y9hfKsYaEg8N7DxqfJ97+YsZUqIl4vJqAgCzG31mObfMehzT5s8KOyt
         lu7JMTP80LczWcDwqtZfquBEdNZT42hQ/ctcE=
Received: by 10.125.143.19 with SMTP id v19mr117656mkn.147.1218026125652;
        Wed, 06 Aug 2008 05:35:25 -0700 (PDT)
Received: by 10.125.93.2 with HTTP; Wed, 6 Aug 2008 05:35:25 -0700 (PDT)
In-Reply-To: <20080806111545.GD32184@machine.or.cz>
Content-Disposition: inline
X-Google-Sender-Auth: 5447eb7cc0d77e0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91508>

On Wed, Aug 6, 2008 at 7:15 AM, Petr Baudis wrote:
> On Wed, Jul 23, 2008 at 01:57:54PM +0100, Johannes Schindelin wrote:
>> Note that you will have to do your digging using msysGit (i.e. the
>> developer's pack, not the installer for plain Git), since git-svn will be
>> removed from the next official "Windows Git" release, due to lack of
>> fixers.
>
>  is there any other problem with git-svn on Windows than the CRLF
> issue? I couldn't find anything significant in the issue tracker.

The main problem currently is that git is Win32, and perl is Msys.
When perl asks git to read files from /tmp (a path that doesn't exist
outside Msys), it grinds to a screeching halt.

The quick and dirty fix is to convince git-svn to write temporary
files somewhere else (maybe by passing DIR => $ENV{GIT_DIR} to
File::Temp::tempname, but I've been too embarrassed to suggest that
publicly).

The correct fix is to switch the msysGit perl from Msys to Vanilla,
but I've been too lazy to finish that up (as the SVN modules quickly
descend into dependancy hell).

Peter Harris
