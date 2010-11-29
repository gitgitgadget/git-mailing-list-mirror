From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable
 path if using argv[0] fails
Date: Mon, 29 Nov 2010 14:19:58 -0600
Message-ID: <20101129201958.GA10334@burratino>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
 <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
 <20101129171211.GL8037@burratino>
 <37CD335A-00A7-4074-BD39-4FCDEEB3D083@apple.com>
 <20101129185030.GB9441@burratino>
 <BED9E026-6804-4ABF-A26D-8F20699BAD0B@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@apple.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:20:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNADC-0000Ag-SU
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab0K2UUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:20:13 -0500
Received: from mail-fx0-f66.google.com ([209.85.161.66]:33728 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0K2UUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:20:10 -0500
Received: by fxm9 with SMTP id 9so2042795fxm.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=O3hZO/NzG4lYGoCjXuMdlr6P8D6L2sq5CbiWfQ/MHJw=;
        b=Axrtb3qHhxYHQ23L3AsSt2kokusXnDZG53GkEU4d3fYqwX+ofwI/HrC1tQiorqPtaj
         KwX5QChgFdS+ox6FIeMPPCk5SpzOOwH1OQ9qlzEigmqT+mn9iaJQzQdK7PIxue6GypS4
         Xn94T6YnRqKCtTEwXM4ejdMEU2TNYDhdrAvxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XflUDGAsFH5jkt2qLY1ZTt4xUFTL4UzLesv/lk8Nba9QEXLEVE2QEiXgNdf0XGgyQ1
         pRCuoKvHmBy701EFhJBZdSxj1yUeD2EhG7pF41beylHj5kL2ivzPxovtErlEP2nORVod
         egUyZ3zsbhIrqEUvXa+MZuPQStNvLyfRpY0nw=
Received: by 10.223.78.136 with SMTP id l8mr5856394fak.82.1291062008839;
        Mon, 29 Nov 2010 12:20:08 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id 21sm1370197fav.17.2010.11.29.12.20.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 12:20:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BED9E026-6804-4ABF-A26D-8F20699BAD0B@apple.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162420>

Jeremy Huddleston wrote:
> On Nov 29, 2010, at 13:50, Jonathan Nieder wrote:
>> Jeremy Huddleston wrote:
>>> On Nov 29, 2010, at 12:12, Jonathan Nieder wrote:

>>>> The section "2) #ifdefs are ugly" of
>>>> linux-2.6/Documentation/SubmittingPatches explains the rationale.
>>> 
>>> I agree, but I don't really see a way around it here since this API is specific to OS X.
>> 
>> Did you actually read that section? :)
>
> Yes, but I don't have the time to "do it right" right now ... I'm
> contributing the patch that we are using back to the community in
> the spirit of OSS development, but I don't have the time resources
> currently to "do it right" at present.  I'll come back to it once
> time allows if nobody else picks it up.

Okay.  Thanks for reporting.

My guess is that the Windows version could be simplified, too, if
we introduce a function to get the path to the binary.  On Linux
it should use "readlink /proc/$$/exe", on Darwin the function you
pointed to, on Win32 _pgmptr, as a fallback look for argv[0] in
$PATH if someone on another platform is interested.

Jonathan
