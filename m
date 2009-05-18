From: Nick Welch <nick@incise.org>
Subject: Running vimdiff in read-only mode with git-difftool?
Date: Sun, 17 May 2009 22:01:02 -0700
Message-ID: <9e00fd550905172201n6c95dc1bia48c9ac25d8ec98f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 07:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5uyS-0000Vj-QA
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 07:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbZERFBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 01:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbZERFBD
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 01:01:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:58222 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbZERFBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 01:01:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1532368rvb.1
        for <git@vger.kernel.org>; Sun, 17 May 2009 22:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=0lu8D0rNVSzkc5sdMwwNeHkaCi48rKSwe2Oa621jWUg=;
        b=AUls3lWKWpEAVT82xcsnGo2MqKp9kmMNOxFdGRpwqB4eQDwOFie3PXbvv9/kMX5rlv
         sEiRjVgjvH+8sm70gfTHfIiYWBvTIK1Cwd6cK0mctMtklGkcMo1qaFmib/08O1M1wa7B
         fqjmRcmVCwIPCNFcINcGRRh2cPHU0O67AxNpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=moZAyDmnF71IqfrR17I0FnGeXh8JW7yS+y9gpsJDQNToOEhPD3ONLFSnKEQX8vqa2a
         kaoYowbc+vmWtWSUkqSpsrajKJmH166/uWqzs/evk3pyR8Y0TGO4Cy+r4MgUJpoCl+Wp
         CyL+IwrH9f1VLEjZ6Z67sXBJGsc4NTHhH6R5k=
Received: by 10.142.84.5 with SMTP id h5mr1823292wfb.200.1242622862745; Sun, 
	17 May 2009 22:01:02 -0700 (PDT)
X-Google-Sender-Auth: 4fc7573b044d41d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119414>

I'm running:

git difftool -y --tool=vimdiff -U99999 --patience

and I have the following in ~/.gitconfig:

[difftool "vimdiff"]
    cmd = "vimdiff -R"

But vimdiff is still run in read/write mode.  In the output of ps, I see:

vim -d -c wincmd l /tmp/.diff_bP2Tjf <original file>

There should be an -R in there, but there's not.  And if I'm trying to
edit <original file> in another instance of vim, I get the annoying "a swap
file exists, what should I do?" message, which is my main motivation in
trying to use read-only mode.

According to the git-difftool manpage, what I'm trying to do should work:

    Instead of running one of the known diff tools, git-difftool can be
    customized to run an alternative program by specifying the command line to
    invoke in a configuration variable difftool.<tool>.cmd.

I've also tried specifying the full path to vim diff, like this:

[difftool "vimdiff"]
    cmd = "/usr/bin/vimdiff -R"

and it didn't work either.

Any ideas?
