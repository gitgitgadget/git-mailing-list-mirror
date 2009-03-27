From: David Reitter <david.reitter@gmail.com>
Subject: Re: How to merge by subtree while preserving history?
Date: Fri, 27 Mar 2009 12:56:43 -0400
Message-ID: <BA69E81F-C93F-4AD8-8486-A27B0A284D9A@gmail.com>
References: <A5C2B218-4E4F-4C05-959D-5B6E9C619DDB@gmail.com> <20090327073847.GE27459@genesis.frugalware.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:58:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnFOE-000485-UW
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 17:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbZC0Q4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 12:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbZC0Q4u
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 12:56:50 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:16843 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbZC0Q4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 12:56:49 -0400
Received: by yw-out-2324.google.com with SMTP id 5so989669ywb.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=6/qL0Ov2DaDLnC5hd9NndYgbUsOgBp7e/vWRSHs015c=;
        b=SB3QnBietGI6E7xRjboiCCRfEc6yJ/ja2HQGvjdu0YJmzJI7NWoIH3MFv+U7/TswhR
         6KiTAtxcgB6i2vu5VmFM4orKy7/kvinyiJMYX9N1RaKrsaF9EsAgWU8vPDqLefzUlZDn
         yLqLULTIzCHNsEtP1au3BJqbxeIo9dFb5ssl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=XZt009N+n06ApWqwP8/jtDMGv17bCUPPz8+fBEDb2ElzfFJJL5zoc0AkFHPpBCxROl
         VDpSqKW48rqkcqF1TiW4xYxUwYeXjOZDH+pdGmAw6Rlx5UiMSivi+2j52VLreEvFddcV
         l/S7Udsbm+fa8t/3LnKWb3G+o/HhWIUuiRw+Y=
Received: by 10.100.46.10 with SMTP id t10mr568850ant.151.1238173007156;
        Fri, 27 Mar 2009 09:56:47 -0700 (PDT)
Received: from SCARLETT.PSY.CMU.EDU (SCARLETT.PSY.CMU.EDU [128.2.249.106])
        by mx.google.com with ESMTPS id c29sm2437321anc.23.2009.03.27.09.56.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 09:56:46 -0700 (PDT)
In-Reply-To: <20090327073847.GE27459@genesis.frugalware.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114912>

On Mar 27, 2009, at 3:38 AM, Miklos Vajna wrote:

> Now do a 'git log f474c52..52b8ea9' and you'll see the merged commits.

Sure :)
Needless to say, this is not practical and doesn't support people's  
workflow.

For simple renames,  "git log --follow" helps, but as soon as you want  
to do a "diff" in one of the listed revisions, filtering for just this  
one file, then history becomes invisible again.   Concretely, this  
breaks the common workflow with C-x C-v l, then "d" in Emacs.

I'm aware of the content-tracking vs. file-tracking discussion; it's  
all fine, except that file names are meaningful meta-data for some  
content, at least in some projects.  Is there a command that gives me  
the diff  for a revision pair, restricted to what happened to content  
in a given file in the current tree?


> But you are right about that 'git log -- path' will find the merge
> commits only (which is right, as the tree objects are not modified  
> when
> merging, just the resulting tree has the original tree in a
> subdirectory).
>
> If this is a one-time operation then I would just use git filter- 
> branch
> to move the code to a subdir.


For the record:

In the meantime, I managed to move the original file in the CVS  
repository (by just moving all the ",v" files and getting rid of  
CVSROOT/history, which doesn't seem needed).  The I re-ran cvsimport,  
mitigating a bunch of problems with "cvsps".  For the record, cvsps /  
cvsimport could not handle the case where my repository named "foo"  
had a subdirectory also called "foo", in which I moved all the  
stuff.   I had to rename the directory to "bar".   I also had to  
delete cvsps's cache file with the -x argument (or delete it from the  
surprising location ~/.cvsps).

Then, I merged with "git pull", noting the rev ID before the merge.

Next, I used "git filter-branch" to rename the directory again from  
BAR to FOO as follows:

git filter-branch --index-filter \
         'git ls-files -s | sed "s-BAR/-FOO/-" |
                 GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
                         git update-index --index-info &&
          mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' <last-rev-before- 
merge>..

Finally, I had to "git gc" to prune a 200MB worth of objects (it told  
me I had 500k objects overall).


--
http://aquamacs.org -- Aquamacs: Emacs on Mac OS X
