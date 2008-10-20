From: "Simon Strandgaard" <neoneye@gmail.com>
Subject: bug: git-stash save and symbolic links
Date: Mon, 20 Oct 2008 10:34:53 +0200
Message-ID: <df1390cc0810200134x68a8eb1fyc7f24650c8c9c5d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 19:00:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrqFI-0002Dk-Cl
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 10:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYJTIez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 04:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbYJTIez
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 04:34:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:12164 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbYJTIey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 04:34:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1844319wfd.4
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=KYiQ2knU0ovkFqstnka69gZ19U3eTjhSOu4G7calLUg=;
        b=ZH9Rcj5hsup2gUQfyxBY7XSJeh1fGvgileXXJvksDYYbW3WBJRdZeoVK49ic/S/xOz
         7HCaOxsCYwgjZNob5q7L0hIb72N4sTKYiYzawkazh0vihy9tmSdaiRfO9BtiWbmb29GJ
         ZsNBzBT2piN3fdhFit+GuW5EqYFm9cY8OV7GA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=iZ+mVF8CPE8Okt1MMrdvmbfmgzAoscZHl1nSZHphcWzf4zzSiSvpq6XTpN/shrruF6
         XRqWfo4TCn//3C0VYKHYRd2WuYIQAXRY7KZVMObzjRzGZN5wZtMgX2RsGzLiZFLPOVw7
         M5bbXi6j2Y5syjaH9OdtZOTDXZNrOVX8+PAzw=
Received: by 10.142.251.15 with SMTP id y15mr2932694wfh.39.1224491693994;
        Mon, 20 Oct 2008 01:34:53 -0700 (PDT)
Received: by 10.143.168.21 with HTTP; Mon, 20 Oct 2008 01:34:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98681>

git-stash cannot find the repository when the path is a symbolic link.
solution for me was to cd to the absolute path and then do git-stash.

FAILURE: git-stash with symbolic link.

prompt> pwd
/Users/neoneye/st
prompt> ls -la ~/st
lrwxr-xr-x  1 neoneye  neoneye  38 10 Okt 07:40 /Users/neoneye/st ->
/Users/neoneye/git/code/source_toolbox
prompt> git-stash
fatal: Not a git repository
fatal: Not a git repository
fatal: Not a git repository
You do not have the initial commit yet
prompt>


SUCCESS: git-stash without symbolic link.

prompt> pwd
/Users/neoneye/git/code
prompt> ls -la
drwxr-xr-x  16 neoneye  neoneye   544 20 Okt 10:18 .git
drwxr-xr-x  29 neoneye  neoneye   986 16 Okt 13:04 source_toolbox
prompt> git stash save "did I mess up"
Saved working directory and index state "On master: did I mess up"
HEAD is now at 90ac45d we can now seek through a WAV file.. finally.
prompt>


I think the problem is located in the save_stash() function, but
im not good at sh scripting to make a patch.



Thank you very much for git!


-- 
Simon Strandgaard
http://toolboxapp.com/
