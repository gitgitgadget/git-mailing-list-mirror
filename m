X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 6 Dec 2006 17:52:39 +0100
Message-ID: <200612061752.39443.jnareb@gmail.com>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061727.54058.jnareb@gmail.com> <4576F29B.6010105@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:50:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R13JhFhDpJgcCrM6aMTznhlbDWO8Hh9lc7w1BDB4MFN8wy/p2KT8K1vx1huaQ00v1ajci1t/xRWIZqFDXmhWBXbNdHiNO6o1x9cy5oGPQk7ccu1TVVllKCZ7G11Oc0RBsGFOEji0U6ZcQNjMVKtYoLB+V2cEIFUU+AsGyuVhLIg=
User-Agent: KMail/1.9.3
In-Reply-To: <4576F29B.6010105@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33489>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grzyh-00005y-Jo for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936488AbWLFQuf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936480AbWLFQuf
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:50:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:57561 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S936501AbWLFQue (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 11:50:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so198019uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 08:50:33 -0800 (PST)
Received: by 10.67.22.7 with SMTP id z7mr1123611ugi.1165423832724; Wed, 06
 Dec 2006 08:50:32 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id l40sm30380197ugc.2006.12.06.08.50.32; Wed, 06 Dec
 2006 08:50:32 -0800 (PST)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> Jakub Narebski escreveu:

>>> there should be Makefiles in said directories. Otherwise, every rule
>>> in the toplevel Makefile saying
>>>
>>>
>>>   $(MAKE) -C subdir/
>>>
>>> will fail because $builddir/ does not have a Makefile in
>>> $builddir/subdir.
>> 
>> Wouldn't it be better just to modify toplevel Makefile to say:
>> 
>>    $(MAKE) -C $(srcdir)/subdir/
>> 
>> without messing with ./configure script, and creating "redirect"
>> Makefiles?
>> 
> 
> that doesn't work.
> 
>   make -C foo bla
> 
> just does 
> 
>   (cd foo && make bla)
> 
> If you did this, part of the object files would end up in the source dir; 
> The idea of separate srcdir builds,is to keep the srcdir completely clean 
> of generated files.  That can't really be done without aid of a script,
> to setup the builddir. In this case that is the configure script.

Thanks for an explanation. At least some of it should be in commit
message, to explain what you want the patch to do.

I don't know autotools enough to check if autotools (autoconf) doesn't
have it's own way to do this, some autoconf macro, to not need to write
this script creating redirect Makefiles.

I'm still not sure if this has place in git. Is it really common to
support building outside source directory? If git didn't support this,
so what?
-- 
Jakub Narebski
