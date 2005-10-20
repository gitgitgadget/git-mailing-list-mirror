From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-send-pack segfaulting on DebianPPC (was: Re: cg-clone, tag objects and cg-push/git-push don't play nice)
Date: Thu, 20 Oct 2005 13:43:48 +1300
Message-ID: <46a038f90510191743r22205cf5ia6e5fd624c2d4949@mail.gmail.com>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
	 <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org>
	 <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
	 <20051019223743.GQ30889@pasky.or.cz>
	 <46a038f90510191623k4f1a7267m50d3bbbd6665a2a3@mail.gmail.com>
	 <20051019235208.GR30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 02:45:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESOXn-0000Ua-4p
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 02:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVJTAnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 20:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVJTAnu
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 20:43:50 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:47004 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751006AbVJTAnt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 20:43:49 -0400
Received: by qproxy.gmail.com with SMTP id v40so221896qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 17:43:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PUI8LYyUmLuMCz441Ud6Bbhuwpycvcr736YJsyQxmCLHZEgnuUSfZmu/Oug+kbodETXqVdUtCirGj+j4xZwLWqYEA1yLvTyaMG3KYXi+noNhonW9FwkpmVsRmTYaEdF8xLoS6sbZwmI0B4MQL7wwFny1O7SfsLs/hP5/OXTMrh4=
Received: by 10.65.242.2 with SMTP id u2mr1048270qbr;
        Wed, 19 Oct 2005 17:43:48 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 17:43:48 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051019235208.GR30889@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10330>

On 10/20/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Oct 20, 2005 at 01:23:11AM CEST, I got a letter
> where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> > Actually, all the tagsrefs have only one line, but something is going
> > weird around tagid=$(cat $tag) as $tag ends up containing many
> > filenames. So I undid my initial change to "head -n1", and I'm trying
> > to fix the loop.
>
> Hmm, what bash version are you using? It's enclosed in
>
>         for tag in *
>
> and perhaps your bash misunderstood.

After a bit of head-scratching, I found out what was causing this one:
legacy tagnames from git-cvsimport that contain '*' in the tagname. So

   tagid=$(cat SOME_TAG **INVALID**)

gives us some really nasty surprises.

cheers,


martin
