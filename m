From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 24 Jan 2008 12:37:26 +1300
Message-ID: <46a038f90801231537j6899a1a2t57cd5af9449267f9@mail.gmail.com>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	 <20080123000841.GA22704@mit.edu>
	 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	 <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
	 <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	 <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	 <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Theodore Tso" <tytso@mit.edu>, "Mike Hommey" <mh@glandium.org>,
	git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 00:38:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHpAY-0006hz-2w
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 00:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYAWXh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 18:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYAWXh3
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 18:37:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:16919 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbYAWXh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 18:37:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so202767ugc.16
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 15:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=h1px1zBsIi2H83b1DkXWxHPnLhKnlvAh2t3kJZB3GDE=;
        b=pm6M9Ay4mcpL01CwdD7xpxboLaB9tBl9sUxKq8oHoPchuVlLbOvrAHQ6aj5KRvn7PyEN9QxMrLJW+ex/VvO0n5rZDn5bkInS10OchWqj847i6sVrCQj5jceE3s6aqixDfpIUk/BCbu771YkHgEu4dXui/LaT5Sn1bIfrmYPxVAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rU8cOEndXwpFju/mkQrRrGXADa724x5KzrjuRnsrKRQA1hA1jzv6KwflOO9YWIyW2sXb9eYPN+ZMYsWaqTh2+98fWoL+fBLyUZAzBBDiEKHtOsdM+fFQDGL1Okk6Z93B2KPUqdBxZkZ+XGQdQj6J3ar/V7QSDg7PAa7b2t0UR/A=
Received: by 10.66.217.20 with SMTP id p20mr1526503ugg.51.1201131446499;
        Wed, 23 Jan 2008 15:37:26 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Wed, 23 Jan 2008 15:37:26 -0800 (PST)
In-Reply-To: <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71575>

On Jan 24, 2008 6:19 AM, Kevin Ballard <kevin@sb.org> wrote:
> I don't get why you're still calling it corruption

Because in a modern Internet-aware world, whoever designs a FS needs
to acknowledge that they will need to store files from other systems
that have other assumptions. That is, if they want to interoperate.

As you noted not long ago, it is a serious problem if an HFS+
partition is shared over NFS. If you look at all the apps that have
problems with this aspect of HFS+ , they are all apps that transfer
files over the network over diverse protocols. That's why it's a
problem with git, because the files may be coming from a different
machine, running any arbitrary OS that git supports.

In such scenario, can you understand why everyone is saying that HFS+
and the VFS should not mangle names, even if it makes sense to some
use cases under OSX? And do you understand why the same applies to
git, being a network-sharing-oriented app?

So -- if OSX was doing things to make it easier for users to find
matching files at the Finder level, that'd be _fine_. But the FS has
to deal with a lot more variety than that. So this is a bad design
decision -- perhaps less obvious under OS8/9, but completely
disastrous with a network OS such as OSX. Call it "different" if you
want, but that's a euphemism for "wrong".

cheers,



m
