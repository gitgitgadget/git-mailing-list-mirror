From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Mon, 20 Sep 2010 17:49:55 +0200
Message-ID: <4C9782A3.5010005@gmail.com>
References: <1jp42v5.w5dez21d3nlciM%lists@haller-berlin.de> <4C973E5B.4090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Sep 20 17:50:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxid9-0004Kl-Co
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 17:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734Ab0ITPuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 11:50:04 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53935 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab0ITPuC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 11:50:02 -0400
Received: by eyb6 with SMTP id 6so1619052eyb.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=D4bJncTGWn5NtwAOAs/KWrRgirmHLhD5iCV5IyL2so8=;
        b=t3Kj1aj7Vz93XAgXYvRbOEbK1S2nyBQXBBZqvEMgPOIScF9/GOI/ClyH68C+127DCD
         5P1Df9yy4xQpHbNC/ipafvQ5gcWCJL2zPVRiV/MRCK8auRMbSnyAOf8N3SmhKU9xPVbX
         eIWkGO9dfhyziZ+PSABszGJ93t01Ek9H8HLtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=QEcymqADsFl8ZTFCG2V95ywP+eaBa3TBxcinkaAaAu9zdITc7T0UhoSetCxTiNBO2q
         czLKJO2RQ644qS/qsD+K+maxD11as5lwDSdmlGEbkw4h2MyUeUYtsfF4fBblnFKm1FZ4
         i0vaHTHv9CoI7/CHHBgcbFaXesLY3FMU4IXow=
Received: by 10.213.105.82 with SMTP id s18mr1650034ebo.46.1284997800641;
        Mon, 20 Sep 2010 08:50:00 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-123-166.multimo.pl [89.174.123.166])
        by mx.google.com with ESMTPS id v8sm11164908eeh.2.2010.09.20.08.49.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 08:49:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <4C973E5B.4090201@gmail.com>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156632>

On 09/20/10 12:58, Artur Skawina wrote:
> On 09/20/10 10:12, Stefan Haller wrote:
>> Seth Robertson <in-gitvger@baka.org> wrote:
> 
>>>          -AA-- subtopic
>>>         /     \
>>>        A---B---C topic
>>>       /         \
>>>  D---E---F---G---H---I---J---K---L---M---N master
>>>                           \         /
>>>                            O---P---Q another-topic
>>>
>>>
>>> In the above example, the subtopic branch merge from AA to C prevents
>>> you from finding out what branch B is on using the original script.
>>
>> When you say "the original script", are you talking about Artur's
>> one-liner or my script?
>>
>> My script gives me exactly the information I want in all cases.  For a
>> given command $1 and a target branch $2, it shows you all merges that
>> were involved in bringing $1 into $2. For example:
>>
>>   Called with "B" "master", it returns H
> 
> No, it will return both C and H, just like my one-liner; this will be
> misleading, the user won't be able to figure out where 'B" came from
> w/o looking at the graph, from output like:
> 
> $ git-show-merges-since B master
> C..... Merge branch 'subtopic' into topic
> H..... Merge branch 'topic'
> 
> The results for 'B' and 'AA' will be exactly the same.
> 
> For 'B', the 'C' merge should be omitted; skipping it because 'B'
> comes in via first parent would probably work, but i can't turn that
> into a one-liner right now...

Yeah, that was it; the script below will correctly handle not only
the simple example above, but also some real cases. 

Usage: git-find-branch-for <rev> [long-lived-branch]

Returns some merge commits, making it easier to find out from which
branch a change originated. Returns nothing if it did not find an
interesting merge all the way up to long-lived-branch (which defaults
to "master")

Example, using git.git:

$ time ../../../stefans-script bac80370817
4fa088209c81845e73756a4173a8c954e25958d2 Merge branch 'jk/run-command-use-shell'
225f78c817755bebff91629cc525a258cf60eaea Merge branch 'master' of git://repo.or.cz/alt-git into jn/autodep
037c43c68e220739e690540de89a6d5835fefe73 Merge remote branch 'ko/master' into jc/read-tree-cache-tree-fix
1m23.271s user   0m2.173s system   1m26.389s elapsed   98.90% CPU

$ time ../../../git-find-branch-for bac80370817                             
4fa08820    Merge branch 'jk/run-command-use-shell'        * jk/run-command-use 1263743895
225f78c8    Merge branch 'master' of git://repo.or.cz/alt-git into jn/autodep   1264500524
037c43c6    Merge remote branch 'ko/master' into jc/read-tree-cache-tree-fix    1278615350
0m0.270s user   0m0.017s system   0m0.287s elapsed   99.87% CPU
$

So it's also a little bit faster.
Received very little testing, i only tried it on a few commits, other
than the example from this thread, but so far seems to do the right
thing for all of them.
Unpikifying is left as an exercise for the user. ;)

artur

------------------------------------------------------------------------------
#! /usr/bin/env pike
// git-find-branch-for <rev> [long-lived-branch]
//    Probably needs pike7.8
#define die(a...) exit(1, "Aborting; %s"+a)

string run(string ... cmdline) {
   mapping r;
   mixed e = catch { r = Process.run( ({@cmdline}) ); };
   if (e || r["exitcode"])
      die("", e?e:r["stderr"]);
   return r["stdout"];
}

mapping commits = ([]);

array parsecommits(string from, string to) {
   array res = ({});
   string id;
   string gitout = run("git", "rev-list", "--format=raw",  "--ancestry-path",
                                          "--date-order", from+".."+to);
   array lines = gitout/"\n";

   foreach (lines, string line) {
      array words = line/" ";
      if (words[0]=="commit") {
         id = words[1][0]!='-' ? words[1] : words[1][1..];
	 commits[id] = ([]);
	 res += ({id});
      }
      commits[id][words[0]] += words[1..];
   }
   return res;
}

int ismerge(string id) {
   return commits[id]["parent"] && sizeof(commits[id]["parent"])>1;
}

mapping desc = ([]);

int main(int argc, array argv) {
   argv[1] = (run("git", "rev-parse", argv[1])/"\n")[0];
   if (argc==2)
      argv += ({"master"});
   argv[2] = (run("git", "rev-parse", argv[2])/"\n")[0];
   array merges = parsecommits(argv[1], argv[2]);
   merges = reverse(merges);
   desc[argv[1]] = 1;
   foreach (merges, string id) {
      if (commits[id]["parent"])
         foreach (commits[id]["parent"], string parent)
            if (desc[parent])
        	desc[id] = 1;
      if (ismerge(id))
         if (!desc[commits[id]["parent"][0]]) {
	    int comtime = (int)commits[id]["committer"][-2];
	    comtime += (int)commits[id]["committer"][-1]/100*60*60;
            write("%.8s %.70s %d\n", id, commits[id][""]*" ", comtime );
	 }
   }
}
------------------------------------------------------------------------------
