From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: When a file was locked by some program, git will work stupidly
Date: Mon, 2 Nov 2015 09:33:16 -0500
Message-ID: <01b901d1157b$699cf5f0$3cd6e1d0$@com>
References: <CABEb4T7V=WEi-ZZm7ywOFASm+=LtAyOz53gqv-jjuzF-3=veeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: "'dayong xie'" <dayong1111@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 15:33:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtGB1-0007tB-5y
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 15:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbbKBOd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 09:33:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:34748 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbKBOd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 09:33:27 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gojira (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id tA2EXOER049087
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Nov 2015 09:33:25 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <CABEb4T7V=WEi-ZZm7ywOFASm+=LtAyOz53gqv-jjuzF-3=veeA@mail.gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
Content-language: en-ca
Thread-index: AdEVKuqlAmOR/owuRCqgUjh+YJmbIwATiBMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280690>


On November-01-15 11:57 PM dayong xie wrote:
>To be specific
>In my Unity project, there is a native plugin,  and plugin's extension is .dll, >and this plugin is under git version control, when Unity is running, the plugin >file will be locked.
>If i merge another branch, which contains modification of the plugin, git will >report error, looks
>like:
>error: unable to unlink old 'xxxxxxx/xxx.dll' (Permission denied) This is not >bad, however, the unfinished merge action will not revert by git, a lot of >changes produced in repository.
>usually it makes me crazy, even worse, some of my partners are not good at >using git.
>Of course, this problem can be avoided by quit Unity, but not every time we can >remember. In my opinion, git should revert the unfinished action when the error >occurred, not just stop.

What version of Unity (or Unity Pro) are you using? Is this experienced with the Commit in MonoDevelop/Visual Studio or are you using a separate git client? 

I have found similar issues in some versions of Unity and MonoDevelop or Visual Studio not saving all files, especially the project files until you have fully exited - nothing to do with git, but your git commits may not contain complete images of your change.

When I use git with Unity, I either have the source committed through MonoDevelop (no issues) if my changes are source-only, or if I have assets and project changes, then I do exit completely so that I am sure Unity flushes everything to disk and I can get a single atomic commit with all the Unity and C# bits using SourceTree or gitk.

OTOH I'm not sure you really should be storing build products out of MonoDevelop or Visual Studio in your git repository. If the DLL can be rebuild automatically on the client - usual answer is yes - then let it. Handle the release build separately - at least in a separate branch that does not involve having the Unity editor open to get in the way.

In my environment, I have added *.dll (and other stuff) to .gitignore so that I do not track dll changes - they get built on demand instead. There are recommended ways of using git in the Unity forums.

Cheers,
Randall
