From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Sun, 21 Feb 2010 23:42:54 -0500
Message-ID: <4B820B4E.7050405@gmail.com>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com> <4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Feb 22 06:24:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjQ8S-0004Js-6P
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 05:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab0BVEnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 23:43:00 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:40368 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab0BVEnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 23:43:00 -0500
Received: by qw-out-2122.google.com with SMTP id 8so405868qwh.37
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 20:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=IQaeEpioPGnQ+0F4h93ljUjlbPalitUQKJWyYrSt4QM=;
        b=SLnA+20oNVKx9m/IPTAk3B6o0iPBBiLh0q3NPtOUn3bcyv909RFu6YaDOYHSYDC4Vy
         g1LUkuw/mKIl9mICIgKnT/5HcZN6h3/gZEeOHmd1cWkgSwVIJygRmdPiTE+YIE2Sp2Mv
         JXLXY9QT7hxIfX3Q8WAk8sWNm/TxWbHbv0XvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=c3096f8/g9x1QQ4x22raA3Zvr6/8xGavC0vQAmsfKTbdJHROsqms34kBLUBSz1ZvrE
         aS0PB7T4HGNlXhV29yKPyLno/IKDkEDRs8Oc7UqLoUI28E63y1fv6b7A4RirsOMT37+L
         vDolvF/mikMAPjMtejOfPFWQQnxdaBe2KGR/4=
Received: by 10.224.95.164 with SMTP id d36mr5591678qan.95.1266813778959;
        Sun, 21 Feb 2010 20:42:58 -0800 (PST)
Received: from ?192.168.2.202? (dsl-152-38.aei.ca [66.36.152.38])
        by mx.google.com with ESMTPS id 20sm2310037qyk.13.2010.02.21.20.42.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 20:42:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <20100219135549.GA31796@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140604>

On 2010-02-19 08:55, Ilari Liusvaara wrote:
> On Fri, Feb 19, 2010 at 02:05:58AM -0500, Gabriel Filion wrote:
>>
>> The Documentation/git-remote-helpers.txt file wasn't really of much help
>> .. It really only barely scratches the subject, but it does not mention
>> how remote-helpers really work internally (e.g. how do they get called:
>> based on protocol used in URLs?)
>>
>> I'm still trying to dig up information about how to actually build, test
>> and use a remote helper. I'll probably be reading code for examples.
> 
> The remote helper is invoked with one or two parameters. 
> 
> There are five cases to consider (as rule, first argument is name of
> remote [pseudo-remote in case URL was used] and the second argument is
> URL to use, if any):
> 
> 1) Remote <remote> without URL line but with VCS line value <helper> was used.
> 
> The called program: git-remote-<helper>  [search $PATH for it].
> Number of arguements: 1
> 1st argument: <remote>
> 
> 2) Remote <remote> with URL using <helper>::<string> syntax was used.
> 
> The called program: git-remote-<helper>  [search $PATH for it].
> Number of arguments: 2
> 1st argument: <remote>
> 2st argument: <string>
> 
> 3) Remote <remote> with URL using <helper>://<rest-of-URL> syntax was used.
> 
> The called program: git-remote-<helper>  [serch $PATH for it].
> Number of arguments: 2
> 1st argument: <remote>
> 2st argument: <helper>://<rest-of-URL>
> 
> 4) URL using <helper>::<string> syntax was used directly on command line.
> 
> The called program: git-remote-<helper>  [serch $PATH for it].
> Number of arguments: 2
> 1st argument: <helper>::<string>
> 2st argument: <string>
> 
> 5) URL using <helper>://<rest-of-URL> syntax was used directly on command
> line.
> 
> The called program: git-remote-<helper>  [serch $PATH for it].
> Number of arguments: 2
> 1st argument: <helper>://<rest-of-URL>
> 2st argument: <helper>://<rest-of-URL>
> 
> 
> Notes:
> 
> - For 2) and 4), the helper name can only contain alphanumeric characters
>   0-9, A-Z and a-z.
> - For 3) and 5), the helper name can't be any of builtin protocols:
>   'rsync', 'file', 'git', 'ssh', 'git+ssh' nor 'ssh+git'.
> - <helper>::<string> is the strongest, followed by VCS line,
>   <helper>:://<rest-of-URL> is weakest.
> 

This will prove quite useful! This summary should be inspired upon to
add details about how remote helpers are called in the documentation.

I created a dummy remote helper script to test how things are called. I
was successful in having a remote created with URL
bzr://some.server/path to be handed down to the script git-remote-bzr.

However, when I tried creating a git-remote-bzr+ssh link pointing to the
git-remote-bzr script so that URLs like bzr+ssh://something/somewhere
(this is how ssh is used with Bazaar) got handed down to the dummy
script, it kept saying the "bzr+ssh" protocol wasn't handled. So, it
would seem I can't have special characters in the helper script name.

How could I get this protocol to be handled by the remote helper? Having
to type bzr::bzr+ssh://something/somewhere looks like a really awkward
thing to write. Also, requiring users to add something to a protocol
that already identifies the type of remote repository (and, that is
already well known and used by users of bzr) is not interesting in a
usability point of view.

-- 
Gabriel Filion
