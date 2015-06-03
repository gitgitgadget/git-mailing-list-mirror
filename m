From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 21:12:09 +0100
Organization: OPDS
Message-ID: <D1F2397B48664FB29734EF1FF3DD0E7E@PhilipOakley>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net> <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net> <loom.20150603T114527-151@post.gmane.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>
To: <git@vger.kernel.org>, "Ed Avis" <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:12:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0F1J-0005m9-JC
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 22:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbbFCUMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 16:12:10 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:49965 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754444AbbFCUMH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 16:12:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CwOABDXm9VPJ6cLFBbgxBUXoZMbbh6hXUEBAKBSE0BAQEBAQEHAQEBAUEkG0EFg1cFAQEBAQMIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHAxQGARIIAgECAwGIIL5JnQ8BAQgCIItDhBpsgx6BFgWMDocGe4M+iBQ+jXSHZIQdPTGCRwEBAQ
X-IPAS-Result: A2CwOABDXm9VPJ6cLFBbgxBUXoZMbbh6hXUEBAKBSE0BAQEBAQEHAQEBAUEkG0EFg1cFAQEBAQMIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHAxQGARIIAgECAwGIIL5JnQ8BAQgCIItDhBpsgx6BFgWMDocGe4M+iBQ+jXSHZIQdPTGCRwEBAQ
X-IronPort-AV: E=Sophos;i="5.13,548,1427756400"; 
   d="scan'208";a="682610809"
Received: from 80-44-156-158.dynamic.dsl.as9105.com (HELO PhilipOakley) ([80.44.156.158])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 03 Jun 2015 21:12:03 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270733>

From: "Ed Avis" <eda@waniasset.com>
Sent: Wednesday, June 03, 2015 10:55 AM
> Jeff King <peff <at> peff.net> writes:
>
>>I would say the more "usual" way to use checkout like this
>>is to give specific paths. I.e., run "git status", say "oh, I need to
>>restore the contents of 'foo', but not 'bar'", and run "git checkout
>>foo". That works regardless of the type of change to "foo" and "bar".
>
> That seems fine - a specific file is named and you clearly want to 
> alter
> the contents of that file.  By analogy, 'rm foo' will silently delete 
> it,
> but if you specify a directory to delete recursively you need the -r 
> flag.
> OK, it's not a perfect analogy because the purpose of rm is to delete 
> data
> and nothing else ;-).
>
> If my personal experience is anything to go by, newcomers may fall 
> into the
> habit of running 'git checkout .' to restore missing files.  In the 
> old days
> I would often delete a file and then run 'cvs update' or 'svn update' 
> to
> restore it.  That would fetch a fresh copy from the repository, and 
> while
> it might do some kind of diff/patch operation on modified files, it 
> would
> not simply throw away local changes.
>
> 'git checkout .' seems like the analogous command, but it has much 
> sharper
> edges.  I still think it should be safer by default, but if you decide
> against that then perhaps you need to create some way to restore 
> missing
> files and not overwrite others.  'git checkout --no-overwrite'?  Then 
> it
> could even be added to .gitconfig as the default for those who like 
> it.
>
> I have to say that as a newcomer to git I do not like the idea of 
> creating
> a special undo log for git.  It would just be yet another concept to 
> learn
> and another thing to add to the list of 'where is git hiding my data 
> this
> time?'.  And the time when it would be useful - after some bungled 
> operation
> that lost data - is just the time when the user is already confused 
> and
> adding another semi-hidden stash of objects to the mix would befuddle 
> them
> further.  If there is to be a backup made of local changes that get 
> lost,
> and I agree it is a good idea, then it should be something stupid and
> completely obvious, such as saving the old file as 
> 'foo.before_checkout.1'.
>
> -- 
> Ed Avis <eda@waniasset.com>
>

To me, when I saw the 'git checkout .', I was reminded of the 'git push 
. <refs>' special case where '.' is the repo, so in my mind the first 
thought was that Ed wanted to checkout the head of the current repo, and 
that should have barfed from that viewpoint.

The [is it equivalent? (rhet)] 'git checkout -- .' would clearly 
indicate that the '.' refers to the files of the current directory 
(wouldn't it?)

So it's about how '.' is perceived by the code in different 
circumstances, and whether, perhaps, the optional discriminating '--' 
should be required in this (special) case.

Philip 
