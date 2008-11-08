From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: Repo corrupted somehow?
Date: Sat, 8 Nov 2008 07:19:13 -0800
Message-ID: <216e54900811080719i43b4a631p241e9d2a54ed5ce9@mail.gmail.com>
References: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com>
	 <alpine.LNX.1.00.0811042241450.19665@iabervon.org>
	 <216e54900811042127id69b61fqbd9d001b8bc17a6a@mail.gmail.com>
	 <alpine.LNX.1.00.0811050043030.19665@iabervon.org>
	 <77005B51-0170-42EC-BBA7-DCF39C7CFC5E@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sat Nov 08 16:23:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kypex-0003bD-HB
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 16:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbYKHPTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 10:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbYKHPTQ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 10:19:16 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:65227 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbYKHPTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 10:19:15 -0500
Received: by gxk4 with SMTP id 4so1359500gxk.13
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 07:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5Qu+G9p9J+Di2ELjOFPj7AErhj/Ocm+e37pqHUlil0Q=;
        b=AIg0mGoqFVrSQQY5GoMgaShvcj2DR1ANVdZTzNf1vYOAjZmn2RrAhlowfDOifdQ9DB
         q9bKvzFglir5eCaogJJHxcgborSb9AsqO1yaWzhe6cqyWt8y8GAzOVJ5WQPfs8l/zOty
         WLd0iGLfwnLK8mKBujqXfI9a/e3bB5KCKx75I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nAah5QYGjDSG4ay+nJ/FBfrEk+SjxJ/aPRtbbVFq1oYDFKERXg/f81E8VfIGV/eSL1
         a4JHi9rQlujgK8L8IET8E6v5y1c4rzZZJSXDDumW1sNxb6YaBMGZXqiG7NlE1a8aUizG
         1a4zUglPzcnFc0wgQfGtvs/jrXXTr9HO8xmVU=
Received: by 10.151.12.4 with SMTP id p4mr5807510ybi.0.1226157553705;
        Sat, 08 Nov 2008 07:19:13 -0800 (PST)
Received: by 10.151.142.12 with HTTP; Sat, 8 Nov 2008 07:19:13 -0800 (PST)
In-Reply-To: <77005B51-0170-42EC-BBA7-DCF39C7CFC5E@orakel.ntnu.no>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100407>

I thought that autocrlf always 'added' CRLF instead of adding merely
CR.  Dang.  I'd rather have CRLF text files.

On Wed, Nov 5, 2008 at 4:26 AM, Eyvind Bernhardsen
<eyvind-git@orakel.ntnu.no> wrote:
> On 5. nov.. 2008, at 06.56, Daniel Barkalow wrote:
>
>> On Tue, 4 Nov 2008, Andrew Arnott wrote:
>>
>>> It was the CRLF conversion.  When I played around with
>>> git config --global core.autocrlf true/false
>>> I got the problem to eventually go away.
>>>
>>> Thanks for all your responses.
>>
>> It's still worth debugging further, because git should know that it wrote
>> the files differently and not see that as changes. It's not too helpful to
>> have autocrlf if it causes this problem.
>
> I think I know what this is.  If a repository contains files with CRLFs,
> those files will show as modified when core.autcorlf is true (if you commit
> them, the CRLFs will be converted to CRs in the repository, so in a sense
> they _are_ modified).  Try turning autocrlf back on, cloning the repository,
> then touching all the files (to make git check them for changes) and see if
> you get the same problem.
>
> I proposed an alternative autocrlf implementation on the list a while back:
> making it an attribute instead of a configuration setting and adding a
> configuration setting to tell git which line ending is preferred when the
> autocrlf attribute is set.
>
> That would allow you to turn on autocrlf and let git convert all CRLFs to
> CRs in a single commit, thus converting a repository with CRLFs to one that
> can be used with autocrlf in a versioned way.  In theory that lets you check
> out new commits with EOL conversion while old commits will be left alone
> (avoiding the problem you saw), but since .gitattributes is read from the
> working directory and not the tree to be checked out, it doesn't work
> perfectly.
>
> I implemented the easy bit (reading autocrlf from .gitattributes), but for
> various reasons the patch has just been gathering dust in my private git.git
> repo.  Maybe I should dust it off :)
> --
> Eyvind
>
>
