From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Problems after deleting submodule
Date: Tue, 18 Oct 2011 21:56:16 +0200
Message-ID: <4E9DD9E0.80808@web.de>
References: <CAHVO_90UN_nNDbqxM2TkUjo_qfVhLgjUJoZTmYi6rsLnRMOUFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Oct 18 21:56:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGFlw-0002Yi-7n
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 21:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab1JRT4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 15:56:20 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:53885 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab1JRT4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 15:56:19 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3C2C41A4BA94D
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 21:56:18 +0200 (CEST)
Received: from [192.168.178.43] ([79.247.255.167]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0ML8F7-1RFyee368H-0003G7; Tue, 18 Oct 2011 21:56:17
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CAHVO_90UN_nNDbqxM2TkUjo_qfVhLgjUJoZTmYi6rsLnRMOUFg@mail.gmail.com>
X-Provags-ID: V02:K0:DvxkWB1WBJKmxCcg+xQtMwLzL5iGQb1j7AZftMCrm8x
 GdaVAS0BIlNTD/1wCGuEMsdHNDWOG1aT5rGMpfUTsRrcp5uGsb
 lduiWfCGqn8Oye5yJrjWZgm8XVxqDAG45d3XwgVwzzxR5C3K4j
 XE4hdQuYy8a8E+o8uj0wFHdkTVV/ZDKlJJ1ZlDd4KSNUpsJLVW
 rZOV7THSfs1SPz6507tIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183900>

Am 18.10.2011 13:54, schrieb Howard Miller:
> I included a submodule in my project then decided I didn't like
> submodules and deleted it again. I followed the advice of delting
> .gitmodules, the bit from .git/config and then git rm'ing the
> submodule. Seemed to work. I then copied files with the same directory
> name into where the submodule was. However, I can't add them.
> 
> Doing git add /path/to/old/submodule - does nothing, files are not
> staged, no error messages no nothing.
> If I try to git rm /path/to/old/submodule - it just says 'did not
> match any files'.
> 
> It simply does not seem to want to add anything to the old submodule
> location. I had a grep around and could not see any obvious references
> in the repo.
> 
> I'm a bit stuck... any suggestions for things I can try much appreciated.

Looks like the gitlink entry of the submodule is still there. I assume
	git ls-files --stage | grep 160000
still shows the submodule? That would make it impossible to add anything
in the former submodule directory.

When I delete .gitmodules and the .git/config entry and do a
	git rm sub/
I get
	fatal: pathspec 'sub/' did not match any files

If I omit the trailing slash it is:
	fatal: git rm: 'sub': Is a directory

I have to do a
	rm -rf sub
followed by
	git rm sub
to get everything cleaned up.

Does that help you?
