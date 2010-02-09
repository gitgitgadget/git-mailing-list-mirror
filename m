From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git + davfs2, is it safe?
Date: Tue, 9 Feb 2010 09:57:12 -0800
Message-ID: <20100209175712.GB28936@spearce.org>
References: <2c173a351002090839v45d01d5dt17e4b4af37e84615@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: G?bor Farkas <gabor@nekomancer.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:57:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeuKu-0003qh-Uk
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454Ab0BIR5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 12:57:16 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:36073 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab0BIR5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 12:57:15 -0500
Received: by iwn1 with SMTP id 1so3746537iwn.24
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 09:57:15 -0800 (PST)
Received: by 10.231.154.77 with SMTP id n13mr1541795ibw.11.1265738235042;
        Tue, 09 Feb 2010 09:57:15 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm212342iwn.6.2010.02.09.09.57.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 09:57:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2c173a351002090839v45d01d5dt17e4b4af37e84615@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139425>

G?bor Farkas <gabor@nekomancer.net> wrote:
> for various reasons our git repositories are hosted using https (webdav),
> which is http-auth and client-certificate authenticated.
> 
> (linux on both the server and the client)
> 
> it's possible to somehow persuade git to push/fetch from such repositories,
> but it's very annoying because either you have to enter your
> username+password+cert_password
> on every fetch and twice on every push, or you have to write them down
> in $HOME/.netrc .

This is why I prefer SSH.  You have ssh-agent around to retain your
key for you.

A more modern Git (1.6.6 or later IIRC) should avoid prompting for
the password twice, because the HTTP client should actually reuse
the connection for the subsequent requests.  But I haven't tested it.

You might also want to consider upgrading your server to post-1.6.6
and stop using WebDAV... but instead use smart HTTP for push.
That should only need one authentication cycle to perform the push.


It sounds like its time for a proper curl-agent for libcurl though.
Users and applications shouldn't have to keep implementing their
password stores as text files...
 
-- 
Shawn.
