From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Status of all files
Date: Sun, 11 Apr 2010 00:12:33 +0200
Message-ID: <4BC0F7D1.6000003@gnu.org>
References: <20100409040434.8602620CBBC@snark.thyrsus.com> <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com> <20100409113248.GB27353@thyrsus.com> <m3sk74hjkg.fsf@localhost.localdomain> <20100409140215.GB27899@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Apr 11 00:12:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0iuz-0007pd-Ca
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab0DJWMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 18:12:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:54448 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab0DJWMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 18:12:39 -0400
Received: by fg-out-1718.google.com with SMTP id 22so55523fge.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DDqFPQLHF3yPPpzt0YAmM37yJ+CQeqH7HxRFaZMrCfk=;
        b=pHhS2XP6F6TA9YAtr9WWVJD68ZXXYi5ZKJYn09/5hhMMSoQGCpMMvFhtefZfvwHlOO
         dg6KS21SN9V+ZnXSyusDQKEBneHhuEdmvF0ccJpJwJZDWcuaL6SD5A8ABh7R//5OPQ2k
         JOloVpG72qWD/nboDgS+ymnWJRXgJK+9tOZ8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dxFY9vczrpb8+dGwiLxYUWYeGwGoKJdRsiv8Otgeq9xxZgCfiIJGW3bo3eDZ6Gn/j2
         jNJJY43GCxRq+NRUpwgW0uWQJs/S2kxJD/Kvy2cNox7sash8QZ9gAGyNhwYpv1wK7MXQ
         AwxeiGA0FHK9Hiart4IE+NdLktBcdByb97/Ak=
Received: by 10.223.5.207 with SMTP id 15mr1734052faw.6.1270937556938;
        Sat, 10 Apr 2010 15:12:36 -0700 (PDT)
Received: from yakj.usersys.redhat.com (s209p8.home.99maxprogres.cz [85.93.118.17])
        by mx.google.com with ESMTPS id 19sm5792333fkr.39.2010.04.10.15.12.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 15:12:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <20100409140215.GB27899@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144600>

On 04/09/2010 04:02 PM, Eric Raymond wrote:
>>> >  >
>>> >  >     'needs-update      The file has not been edited by the user, but there is
>>> >  >                        a more recent version on the current branch stored
>>> >  >                        in the master file.
>> >
>> >  Needs*update*  looks like it came from centralized VCS like CVS and
>> >  Subversion, where you use update-the-commit method.  You can't say
>> >  that HEAD version is more recent that working file...
>> >
>> >  The rought equivalent would be that upstream branch for current
>> >  branch (e.g. 'origin/master' can be upstream for 'master' branch) is
>> >  in fast-forward state i.e. current branch is direct ancestor of
>> >  corresponding upstream branch, and the file was modified upstream.
>
> Agreed. But there's no way to tell that this is the case without
> doing a pull operation or otherwise querying origin, and I'm
> not going to do that.

You can query the origin _as it was on the last fetch_.

If you are on branch X, the logic is as follows:

- Let R be the value of configuration key branch.X.remote,
- let M be the value of configuration key branch.X.merge,
- for all values S of configuration key remote.R.fetch,
   - strip an initial +
   - if S is M:N, return N
   - if S is P/*:Q/* where P is a prefix of M, take M, replace this
     prefix with Q and return the result

In the most common case you will have:

- X = master
- R = origin
- M = refs/heads/master
- one key S = +refs/heads/*:refs/remotes/origin/*

so the prefix "refs/heads/" is replaced with "refs/remotes/origin/" and 
the result is refs/remotes/origin/master.

Paolo
