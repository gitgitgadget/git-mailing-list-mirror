From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Tue, 22 Apr 2008 10:13:39 -0700 (PDT)
Message-ID: <m37ieprexc.fsf@localhost.localdomain>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
	<1208355577-8734-2-git-send-email-pkufranky@gmail.com>
	<1208355577-8734-3-git-send-email-pkufranky@gmail.com>
	<7v3ape5sip.fsf@gitster.siamese.dyndns.org>
	<46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
	<7v3ape2ufs.fsf@gitster.siamese.dyndns.org>
	<46dff0320804220209n590a0684x876270c7b1c0c2d@mail.gmail.com>
	<46dff0320804220738u760a05f7q4ec9cbf144d78480@mail.gmail.com>
	<46dff0320804220741p4d3f3080w493fb96dc4983a1c@mail.gmail.com>
	<alpine.DEB.1.00.0804221609200.4460@eeepc-johanness>
	<46dff0320804220954y171df9b6t199f4864a32d4195@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:14:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoM4h-0005DM-Hg
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761016AbYDVRNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761503AbYDVRNp
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:13:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:41827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758257AbYDVRNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:13:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so191576ugc.16
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=+qMd/Azu0r5ngAeq4nW2LmeAbt2oB2ZeVBBgfsfbpis=;
        b=Gu/bCZJCOlIxcQXGkunBR11P0fixbfhwY1n5z2MKuZqJB8/UJ3RX54C4UbzZwhceW03mymtIOWuayWrQct99jXTpT59AY3rie07Qab4h4OsHVjeNEWDQ43aPVAHX2cuBmLDE2lAU/+VZ/viHW0dpCwwgcnf482QLrGdYToPcM+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=jHZyR6eruzAEsBkQJXX+LdGRHMA/hfmNVrncrQcMaqDzenP6u53tCBaJePbgJwBHmW2srBdJ3+RH4gDAgwr1Uil9c4QIKx0/wYgEVAdapyIyFnM2bf+rOcrOE1tT46avIFtydSYmsxrAeOwJLQoIiUSpK4gXO46QeB+kCnr/Zhw=
Received: by 10.67.119.15 with SMTP id w15mr7131633ugm.73.1208884420982;
        Tue, 22 Apr 2008 10:13:40 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.207])
        by mx.google.com with ESMTPS id 40sm106970uge.2.2008.04.22.10.13.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Apr 2008 10:13:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3MHDaHm005327;
	Tue, 22 Apr 2008 19:13:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3MHDJ5a005323;
	Tue, 22 Apr 2008 19:13:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <46dff0320804220954y171df9b6t199f4864a32d4195@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80143>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Tue, Apr 22, 2008 at 11:10 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>  On Tue, 22 Apr 2008, Ping Yin wrote:
[...]
>>> Only the commit message changes.
>>>
>>> [... only the commit message ...]
>>
>>  Do you realize how much work you make Junio do?  It would be definitely
>>  better if you tried to relieve him of as much burden as you can.
> 
> I'm sorry about that. It's just because that i don't have a mail
> client at hand. I use gmail which will wrap lines. And if i use
> git-sendmail, i can't send this message as a reply to previous
> messages.

Errr, '--in-reply-to' option to git-send-email?

Or find some mail client...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
