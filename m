From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Like commit -a, but...
Date: Mon, 05 Nov 2012 21:36:28 +0000
Message-ID: <1352151388-ner-1077@calvin>
References: <20121105202948.GA17505@inner.h.apk.li>
	<20121105205628.GG21244@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
To: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 22:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVUNN-0003yk-7T
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 22:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045Ab2KEViU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 16:38:20 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62757 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932918Ab2KEViU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 16:38:20 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so3230779eek.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=a6kKd0rzXxx805sPs8M+IH/nV4mEtPpXbLiaaDLkKvo=;
        b=cgaHSFc4wSnH+il1a2skU/ONs+l4/s7E807vgnLrU+vm1Kq/FQKWZMPiIs7FNcSQUh
         O6JfYrAe3rAIHQVd8atJcyv24rKnH6hsJzbF25nvTM6WUAzLvPa+/qDOfBvuXuNUUdss
         bMlg8mc0mxWPax9LjJyNTQj3k4e4MPxxDqswVm0MPM0ye+Q5YIAtYDLJ5dPBVPUEj+Mk
         zrCQvWpmFm51bn6/7ov2bZlfr9E4Vgx9oqNxWKlKicJyGM6qrozhWhc3QIoJCmpgdZ9k
         CsEQ8rOQ2TD3k5sIHic0tb63CtXKvYBPL7YkH8aPvxQNgiwLyWzvw83aZ1fz0AlO6/vE
         bC6g==
Received: by 10.14.173.67 with SMTP id u43mr41171096eel.27.1352151498958;
        Mon, 05 Nov 2012 13:38:18 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id s1sm51059200eem.9.2012.11.05.13.38.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 13:38:18 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 9ADEB145515; Mon,  5 Nov 2012 21:36:28 +0000 (UTC)
In-Reply-To: <20121105205628.GG21244@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209085>

On Mon, 05 Nov 2012 21:56:28 +0100, Andreas Krey <a.krey@gmx.de> wrote:
> On Mon, 05 Nov 2012 21:29:48 +0000, Andreas Krey wrote:
> ...
> > But still I'd like to know if there is a cleaner solution,
> > esp. with respect to the index.
> 
> Actually, it seems
> 
>  commit -m 'index'
>  commit -a -m 'worktree'
>  ...push
>  git reset HEAD^
>  git reset --soft HEAD^
> 
> might do the index trick.
> 
> But is there a direct way to convert the current working tree into a
> tree object?

PARENT=$(git rev-parse HEAD)
TREE=$(git write-tree)
COMMIT=$(git commit-tree -p $PARENT -m "message' $TREE)
git push origin $COMMIT:refs/heads/teh-branch

write-tree+commit-tree is what git-commit does internally.
