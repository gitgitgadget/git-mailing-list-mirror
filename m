From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: --progress for git submodule update?
Date: Thu, 15 Mar 2012 23:34:31 +0100
Message-ID: <4F626E77.1050309@web.de>
References: <CAOVFbFiBOH2MyC3HUtf=hA_PssSRENW7uwpBVxh0TwnO7h90XA@mail.gmail.com> <4F5D0FFD.1020509@web.de> <CAOVFbFhMfpFa5=a0Z50H7nHdQFHn9Y4ApUnQJq6GCOFP+AKy5A@mail.gmail.com> <4F60F4A6.1070507@web.de> <7vd38eoo0u.fsf@alter.siamese.dyndns.org> <CAOVFbFj4nF1GmqdDSmb4z_JXXTxsNktRGaaReF8=msbOwaRt=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Kees <cekees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 23:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8JFr-000185-QX
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 23:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209Ab2COWej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 18:34:39 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:63556 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761175Ab2COWei (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 18:34:38 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id 5CC436B713BA
	for <git@vger.kernel.org>; Thu, 15 Mar 2012 23:34:37 +0100 (CET)
Received: from [192.168.178.48] ([91.3.184.147]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MKaHP-1S984B3sDX-0024rJ; Thu, 15 Mar 2012 23:34:37
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAOVFbFj4nF1GmqdDSmb4z_JXXTxsNktRGaaReF8=msbOwaRt=g@mail.gmail.com>
X-Provags-ID: V02:K0:PD4/koz21mI8o4XvGVcDHVN5euZJ8TfMWQ9b6w7u/56
 id7+5r0tolCrVmt+CRjcDI6ppnLDpdE3Hs1ZjyZmVh4i60X2E4
 t3asjuLuJ0xaEj/ZIfJS54c+iJXn7RnSQ4ZZoNGdpkOLTb3tiZ
 CbshYb0zD4FyCjdGmqRaEpuRpR/lzF2c8etXK5SvTT5EhpqapG
 M4LfGyXMTqA4kZXXBECFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193236>

Am 15.03.2012 04:43, schrieb Chris Kees:
> Yes, I meant when they have to be cloned initially. It was actually
> the builtbot developers who asked me to post a request because the
> lack of output is used to trigger the timeout and the output is
> conveniently stored and posted to the web so you can see what is
> happening on a given platform. Here is the snippet from the log of a
> machine failing because the python submodule of the project is taking
> too long--clearly a slow network issue since python generally
> shouldn't take more than 20 minutes to clone:
[snip]
> '467ba035ba72acd7df28c648b1a52ecadebe4935'
> Cloning into externalPackages/python...
> 
> command timed out: 1200 seconds without output, attempting to kill
> process killed by signal 9
> program finished with exit code -1
> elapsedTime=2641.623387

Ok. Another option you have is to avoid the long clone times. Clone
the external repo locally (but outside your build environment) and
instead of cloning the whole repo each time over the net just do a
fetch into the local copy (to get the latest updates over the slow
network). Then clone from there into your build environment (after
the buildbot edited the submodule url entry in .git/config to point
to the local copy). That should work substantially faster.
