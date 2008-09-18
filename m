From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 1/8] git-gui: Cleanup handling of the default encoding.
Date: Thu, 18 Sep 2008 19:14:32 +0400
Message-ID: <bb6f213e0809180814w74da6e36pfcf5a0622164ad44@mail.gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
	 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
	 <20080918150238.GC21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Paul Mackerras" <paulus@samba.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:15:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLEO-00038R-4M
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbYIRPOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbYIRPOg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:14:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:38460 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbYIRPOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:14:35 -0400
Received: by ug-out-1314.google.com with SMTP id k3so750827ugf.37
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fx/sw9w4bdn2ASvGIxdgSYz7g75BgxOPTxrjV0NH/Zw=;
        b=B99wnrSu9nkwDHQ/xHH6jQD8TpUPzsXSQplvGwHg0I02nUgAnJZv24RCQXaWqQf5BT
         oEZr6wilBLCjJivNXDYQ0oipIgW6MmzDXCxpukHFkQm4cmbg6qQB8Cht8jEpbPIeVFix
         Pg11ijBgvqE3DvzMCrguDF1BiV/ut/KfFcfPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l64SZNWi4EFaCslJ6aPtwGOLcEw5Dt3P5qzfXW9B1P31WtEhy4/UgtgC065KgotEWC
         DhNYBGgB+edn2XG/bp2j8zUqmrBSkrGtzHttD7XqCYV3ieuvFttdACYeMK4e4VbaCUyg
         43dN+/JCofNT+9FoTWlGReI1F7yB14lb+VmuI=
Received: by 10.103.213.10 with SMTP id p10mr3003251muq.46.1221750872306;
        Thu, 18 Sep 2008 08:14:32 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Thu, 18 Sep 2008 08:14:32 -0700 (PDT)
In-Reply-To: <20080918150238.GC21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96199>

On Thu, Sep 18, 2008 at 7:02 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> The subject line of this patch is a bit misleading. I would not expect
> from "clean up" to change the existing behavior and existing default.

Comments can be easily changed.

>> The rationale for this is Windows support:
>>
>> 1) Windows people are accustomed to using legacy encodings
>>    for text files. For many of them defaulting to utf-8
>>    will be counter-intuitive.
>> 2) Windows doesn't support utf-8 locales, and switching
>>    the system encoding is a real pain. Thus the option.
>
> I don't care much what is the default for Windows, but I wonder whether
> this rationale is good enough to change the default for other platforms.
> If you have systems configured with utf-8 and others (usually old ones)
> with legacy encoding, you will store files in utf-8 in your repo, thus
> having utf-8 as the default makes sense for non-Windows platforms.

In fact, I think that the only reasonable default is the locale
encoding. If they want something different, they can do "git config
--global gui.encoding utf-8", that's what the option is there for.

> BTW, when you said the system encoding above, what exactly encoding do
> you mean? AFAIK, Windows has two legacy encodings OEM-CP and ANSI-CP.
> If I write a console program and compile it using MS-VC then it should
> use OEM-CP.  However, if you write a GUI program or a console program
> that is compiled using gcc from Cygwin, you have to use ANSI-CP. For
> instance, if you use the Russian locale on Windows, ASNI-CP is 1251 and
> OEM-CP is 866. So, my question is what exactly encoding do you call as
> "system" above?

Whatever Tcl thinks the system encoding is. In this case it is cp1251.
CP866 is for DOS.

Alexander
