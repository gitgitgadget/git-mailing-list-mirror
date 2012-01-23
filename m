From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH git-remote-bzr] Adapt to new semantics of
 remote-helper "import" command
Date: Sun, 22 Jan 2012 18:12:28 -0600
Message-ID: <20120123001228.GA1209@burratino>
References: <20120122054657.GA25103@burratino>
 <4F1C9D4C.6090603@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Mon Jan 23 01:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp7Wx-00024E-9S
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 01:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab2AWAMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 19:12:39 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36358 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab2AWAMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 19:12:38 -0500
Received: by ghrr11 with SMTP id r11so3394ghr.19
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 16:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gB3JdT80kymbzUTXiFkIKZp0LO1iYPFvGLDNZ1R4DCg=;
        b=R+RO5DwUtqQyL/EvnPjEDIkmHerXvbYgP5sa3ZU40V6OlrEIIcFuVdWklLPTHwwpCQ
         YVyXJgTRuqf1mSALisNNz0gWgEhSPzNqTChuD3n9bgpKpp4KlQmMRTnr+3qoi6ZGWAW3
         sszGlqHsd0nwcwOA+TPRoxQ72g6Ca6+lxxziQ=
Received: by 10.236.193.41 with SMTP id j29mr8364191yhn.12.1327277557713;
        Sun, 22 Jan 2012 16:12:37 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m2sm18979727ann.20.2012.01.22.16.12.36
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jan 2012 16:12:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F1C9D4C.6090603@samba.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188975>

Jelmer Vernooij wrote:
> On 01/22/2012 06:46 AM, Jonathan Nieder wrote:

>> BTW, would you mind if I sent a patch to include git-remote-bzr in
>> git.git under contrib/?
>
> Please note that the bzr-git package, which provides git integration
> for bzr and vice versa, also includes a 'git-remote-bzr' command.

That's good to hear.  Then there should be no need for git.git to have
its own helper.

Unfortunately, when I try to clone any repo, at the last step I get

 Traceback (most recent call last):map 6/7
  File "/usr/lib/git-core/git-remote-bzr", line 220, in <module>
    commands[argv[0]](argv, shortname, remote_dir)
  File "/usr/lib/git-core/git-remote-bzr", line 89, in cmd_list
    for ref, git_sha1 in refs.as_dict().iteritems():
  File "/usr/lib/python2.7/dist-packages/dulwich/repo.py", line 196, in as_dict
    ret[key] = self[("%s/%s" % (base, key)).strip("/")]
  File "/usr/lib/python2.7/dist-packages/dulwich/repo.py", line 267, in __getitem__
    _, sha = self._follow(name)
  File "/usr/lib/python2.7/dist-packages/dulwich/repo.py", line 249, in _follow
    contents = self.read_ref(refname)
  File "/usr/lib/python2.7/dist-packages/dulwich/repo.py", line 225, in read_ref
    contents = self.read_loose_ref(refname)
  File "/usr/lib/python2.7/dist-packages/bzrlib/plugins/git/refs.py", line 129, in read_loose_ref
    tag_name = ref_to_tag_name(ref)
  File "/usr/lib/python2.7/dist-packages/bzrlib/plugins/git/refs.py", line 89, in ref_to_tag_name
    raise ValueError("unable to map ref %s back to tag name" % ref)
 ValueError: unable to map ref refs/heads back to tag name

Will file a bug.
